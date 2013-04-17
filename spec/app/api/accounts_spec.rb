describe API::Accounts do
  let(:partner) { create :partner }
  let(:account) { create(:account, name: "John Doe", email: "john.doe@example.com", partner_id: partner.id) }

  describe "GET /v1/accounts/:id", fdoc: '/accounts/:account_id' do
    it_behaves_like "API with authentication" do
      before { get "/v1/accounts/#{account.id}" }
    end

    it "should return account info" do
      get "/v1/accounts/#{account.uuid}", api_key: partner.api_key

      response.content_type.should == 'application/json'
      response.status.should == 200
      response_json.should == account_json(account)
    end

    context "with wrong account_id" do
      it "should not return account info" do
        get "/v1/accounts/WRONG_ID", api_key: partner.api_key

        response.content_type.should == 'application/json'
        response.status.should == 404
        response_json.should == {
          "status"      => 404,
          "status_code" => "not_found",
          "error"       => "Couldn't find account with id WRONG_ID"}
      end
    end
  end


  describe "POST /v1/accounts", fdoc: '/accounts' do
    let(:params) { SampleRequests::create_account.to_json }

    it_behaves_like "API with authentication" do
      before { post "/v1/accounts", params }
    end

    it "should create an account" do
      post "/v1/accounts", params.merge(api_key: partner.api_key)

      created_account = partner.accounts.last
      created_account.name.should eq "John Doe"
      created_account.email.should eq "john.doe@example.com"

      response.content_type.should == 'application/json'
      response.status.should == 201
      response_json.should == account_json(created_account)
    end

    it "should not allow create empty account" do
      post "/v1/accounts", {account: {name: ""}}.merge(api_key: partner.api_key)
      partner.should have(0).accounts

      response.content_type.should == 'application/json'
      response.status.should == 403
      response_json.should == {
        "error"       => "Validation failed: email can't be blank, name can't be blank",
        "status"      => 403,
        "status_code" => "record_invalid"
      }
    end
  end
end
