# A sample Gemfile
source 'https://rubygems.org'

gem 'rack', '~> 1.5.2'
gem 'grape', '~> 0.5.0'
gem 'grape-swagger'
gem 'sprockets', '~> 2.0'
gem 'activerecord', '~> 3.2.11', require: 'active_record'
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production
gem 'rake'
gem 'roar'
gem 'encode_with_alphabet'
gem 'rack-ssl-enforcer'
gem 'newrelic_rpm'
gem 'newrelic-grape'
gem 'racksh'
gem 'json-schema', '< 2.0.0' # temporarily avoid change in json-schema require syntax
gem 'fdoc'

group :development do
  gem 'rerun'
end

group :test do
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rb-inotify', '~> 0.8.8', require: false
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end
