require 'lib/fdoc/markdown_endpoint_presenter'

class API::Base < Grape::API
  def self.inherited(subclass)
    super
    subclass.instance_eval do
      helpers API::Base::Auth
      helpers API::Base::CurrentResources
      helpers API::Base::Representation
      version 'v1', :using => :path
      format :json

      rescue_from ActiveRecord::RecordNotFound do |e|
        message = e.message.gsub(/\s*\[.*\Z/, '')
        Rack::Response.new(
          [{ status: 404, status_code: "not_found", error: message }.to_json],
          404,
          { 'Content-Type' => 'application/json' }
        )
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        record = e.record
        message = e.message.downcase.capitalize
        Rack::Response.new(
          [{ status: 403, status_code: "record_invalid", error: message }.to_json],
          403,
          { 'Content-Type' => 'application/json' }
        )
      end
    end
  end

  def self.fdoc_endpoint(endpoint_name)
    endpoint_path = Application.config.root + '/docs/fdoc/' + endpoint_name + '.fdoc'
    @fdocs ||= {}
    @fdocs[endpoint_name] ||= Fdoc::Endpoint.new(endpoint_path)
    Fdoc::MarkdownEndpointPresenter.new(@fdocs[endpoint_name]).to_markdown
  end

  module CurrentResources
    def current_partner
      @current_partner ||= Authentication.authenticate_partner(params[:api_key])
    end

    def current_account
      @current_account ||= current_partner.find_account(params[:account_id])
    end
  end

  module Auth
    def authenticate!
      error!({status: 401, status_code: 'unauthorized'}, 401) unless current_partner
    end
  end

  module Representation
    def represent(resource, env)
      BaseRepresenter.represent(resource, env)
    end

    def represent_collection(collection, env)
      BaseRepresenter.represent_collection(collection, env)
    end
  end
end
