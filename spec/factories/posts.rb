FactoryGirl.define do
  factory :post do
    title "A post"
    content "#This is a post"
    user
  end
end
