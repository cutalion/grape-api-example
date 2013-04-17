shared_examples_for "API with authentication" do
  specify { response.content_type.should == 'application/json' }
  specify { response.status.should == 401 }
  specify do
    response_json.should == {
      'status'      => 401,
      'status_code' => 'unauthorized'
    }
  end
end
