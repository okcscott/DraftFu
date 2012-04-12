FactoryGirl.define do
  factory :player do
    sequence(:name) { |n| Forgery(:name).full_name}
    sequence(:position) { |n| Forgery(:football).position }
    sequence(:rank) { |n| n }
  end
end