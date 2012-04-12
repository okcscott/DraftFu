FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| Forgery(:name).company_name }
    sequence(:pick) { |n| n }
    league
  end
end