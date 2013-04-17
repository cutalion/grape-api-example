# encoding: utf-8
describe Partner do
  subject(:partner) { build :partner }

  it { should validate_presence_of :business_name }
  it { should validate_uniqueness_of :business_name }
  it { should ensure_length_of(:business_name).is_at_most(22) }
  it { should allow_value('azAZ09.<>(){}[]+&!$*').for(:business_name) }
  it { should allow_value(';-%_?:#@~=\'" ^\\`|').for(:business_name) }
  it { should_not allow_value("悪").for(:business_name) }
  it { should_not allow_value("    ").for(:business_name) }


  it "should generate an API key" do
    partner.save
    partner.api_key.should_not be_blank
  end

  it "should generate uuid" do
    partner.save
    partner.uuid.should_not be_blank
  end
end
