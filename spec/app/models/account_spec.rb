describe Account do
  subject(:account) { Account.new(attributes_for :account) { |a| a.partner_id = 1 } }

  it { should validate_presence_of :email      }
  it { should validate_presence_of :name       }
  it { should validate_presence_of :partner_id }

  it "should validate email uniqueness" do
    account.save
    new_account = Account.create email: account.email
    new_account.errors[:email].should include "has already been taken"
  end

  it "should generate token" do
    account.save
    account.uuid.should_not be_nil
  end
end
