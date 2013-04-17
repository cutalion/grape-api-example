describe Authentication do
  describe ".authorize_partner" do
    context "when API key is provided" do
      context "partner exists" do
        it "should return found partner" do
          partner = create :partner
          Authentication.authenticate_partner(partner.api_key).should == partner
        end
      end

      context "partner does not exist" do
        it "should return nil" do
          Authentication.authenticate_partner("any_key").should be_nil
        end
      end
    end

    context "when API key is not provided" do
      it "should return nil" do
        Authentication.authenticate_partner(nil).should be_nil
      end
    end
  end
end
