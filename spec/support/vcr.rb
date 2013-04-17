VCR.configure do |c|
  c.ignore_request { |req| !ENV['CI'].nil?  }

  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.default_cassette_options = { :record => :once, :erb => true }
  c.configure_rspec_metadata!
end
