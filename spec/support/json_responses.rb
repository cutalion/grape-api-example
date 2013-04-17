def account_json(account)
  {
    'id'    => account.uuid,
    'name'  => account.name,
    'links' => [
      { 'rel' => 'self',     'href' => "/v1/accounts/#{account.uuid}" },
    ]
  }
end
