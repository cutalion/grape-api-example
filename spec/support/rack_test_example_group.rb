module RackTestExampleGroup
  require 'rack/test'
  require 'fdoc/spec_watcher'

  include Rack::Test::Methods
  include Fdoc::SpecWatcher

  def app
    subject
  end

  def response
    last_response
  end

  def response_json
    JSON.parse(response.body, max_nesting: 19)
  end
end

RSpec.configure do |config|
  config.include RackTestExampleGroup, type: :rack, example_group: {
    file_path: %r{(spec/app/api)|(spec/app/assets/javascripts)}
  }
end
