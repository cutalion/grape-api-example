module SampleRequests
  class JSONString < String
    def to_json
      JSON.parse(self)
    end
  end

  class << self
    def create_account
      JSONString.new <<-JSON.strip
        {
          "account":
          {
            "name": "John Doe",
            "email": "john.doe@example.com"
          }
        }
      JSON
    end
  end
end
