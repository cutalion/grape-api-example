module RouteHelpers
  def accounts_url(api_version)
    "/#{api_version}/accounts"
  end

  def account_url(api_version, account_id)
    accounts_url(api_version) + "/#{account_id}"
  end
end
