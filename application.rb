require File.expand_path('../environment', __FILE__)

module API
end

require 'app/helpers/route_helpers'
require 'app/doc/sample_requests'
require 'app/api/base'
require 'app/representers/base_representer'
require 'newrelic-grape'

Dir["#{File.dirname(__FILE__)}/app/models/extensions/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each {|f| require f}

ActiveRecord::Base.instance_eval do
  include ActiveModel::MassAssignmentSecurity
  attr_accessible []
end


class API::Root < Grape::API
  format :json

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  mount API::Status
  mount API::Accounts

  add_swagger_documentation mount_path: '/api/doc',
                            api_version: 'v1',
                            markdown: true,
                            hide_documentation_path: true,
                            base_path: Application.config.base_path
end

SprocketsApp = Sprockets::Environment.new
SprocketsApp.append_path "app/javascripts"

ApplicationServer = Rack::Builder.new {
  if ['production', 'staging'].include? Application.config.env
    use Rack::SslEnforcer
  end

  use Rack::Static, :urls => [
    "/css",
    "/images",
    "/lib",
    "/swagger-ui.js",
    "/create_card.html"
  ], :root => "public", index: 'index.html'

  map "/javascripts" do
    run SprocketsApp
  end

  map "/" do
    run API::Root
  end
}
