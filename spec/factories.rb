FactoryGirl.define do
  sequence(:email)         { |n| "email#{n}@example.com" }
  sequence(:name)          { |n| "John Doe #{n}" }
  sequence(:business_name) { |n| "Partner #{n}" }

  factory :partner do
    business_name
  end

  factory :account do
    name
    email
  end
end
