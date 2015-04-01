FactoryGirl.define do
  factory :user do
    sequence(:email) do |n|
      "user-#{n}@example.com"
    end
    password_digest "password"
  end
end
