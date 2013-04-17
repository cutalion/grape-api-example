#!/usr/bin/env rake
require File.expand_path('../environment', __FILE__)

task :rails_env do
end

task :environment do
end

module Rails
  def self.application
    Struct.new(:config, :paths) do
      def load_seed
        require File.expand_path('../application', __FILE__)
        require File.expand_path('../db/seeds', __FILE__)
      end
    end.new(config, paths)
  end

  def self.config
    require 'erb'
    db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)
    Struct.new(:database_configuration).new(db_config)
  end

  def self.paths
    { 'db/migrate' => ["#{root}/db/migrate"] }
  end

  def self.env
    env = ENV['RACK_ENV'] || "development"
    ActiveSupport::StringInquirer.new(env)
  end

  def self.root
    File.dirname(__FILE__)
  end
end

namespace :g do
  desc "Generate migration. Specify name in the NAME variable"
  task :migration => :environment do
    name = ENV['NAME'] || raise("Specify name: rake g:migration NAME=create_users")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")

    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF.strip_heredoc
        class #{migration_class} < ActiveRecord::Migration
          def self.up
          end

          def self.down
          end
        end
      EOF
    end

    puts "DONE"
    puts path
  end
end

Rake.load_rakefile "active_record/railties/databases.rake"
