require "English"
require 'open3'

describe "FDocs Readiness" do
  specify "documentation prepared by fdocs should not have undefnied values" do
    grep_undefined_values do |undefnied_values|
      undefnied_values.should_not include "???"
    end
  end

  def grep_undefined_values
    Open3.popen3(grep_command) do |stdin, stdout, stderr, wait_thr|
      error = stderr.read.to_s
      raise error unless error.empty?
      yield stdout.read
    end
  end

  def grep_command
    %Q{grep -nHr --include="*.fdoc" "???" #{docs_path}}
  end

  def docs_path
    File.expand_path('../../../docs/fdoc', __FILE__)
  end
end
