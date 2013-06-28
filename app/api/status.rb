class API::Status < API::Base
  desc "Returns the status of the API", notes: fdoc_endpoint('status-GET')
  get '/status' do
    { status: 'ok' }
  end
end
