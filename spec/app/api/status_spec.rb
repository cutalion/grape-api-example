describe API::Status do
  describe "GET /v1/status" do
    it "returns OK", :fdoc => 'status' do
      get "/v1/status"
      response.status.should == 200
      response_json.should == { 'status' => 'ok' }
    end
  end
end
