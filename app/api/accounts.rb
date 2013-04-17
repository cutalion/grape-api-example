class API::Accounts < API::Base
  desc "Returns account details", notes: fdoc_endpoint('accounts/:account_id-GET')
  params do
    requires :account_id, type: String, desc: "Account ID"
  end
  get '/accounts/:account_id' do
    authenticate!
    represent(current_account, env)
  end


  desc "Creates an account", notes: fdoc_endpoint('accounts-POST')
  params do
    requires :account, type: Hash, desc: "Account attributes"
  end
  post '/accounts' do
    authenticate!
    account = current_partner.add_account(params[:account])
    represent(account, env)
  end
end
