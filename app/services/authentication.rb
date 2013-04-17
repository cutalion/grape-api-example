class Authentication
  def self.authenticate_partner(api_key)
    Partner.where(api_key: api_key).first
  end
end
