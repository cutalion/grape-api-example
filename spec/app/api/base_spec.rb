class TestBase < API::Base
  get "/:some_id" do
    raise ActiveRecord::RecordNotFound, "Couldn't find SomeRecord with id=#{params[:some_id]} [WHERE \"some_records\".\"partner_id\" = xx]"
  end
end

describe TestBase do
  it "should rescue from ActiveRecord::RecordNotFound" do
    get "/v1/42"
    response.content_type.should == 'application/json'
    response.status.should == 404
    response_json.should == {
      'status'      => 404,
      'status_code' => 'not_found',
      'error'       => "Couldn't find SomeRecord with id=42"
    }
  end
end
