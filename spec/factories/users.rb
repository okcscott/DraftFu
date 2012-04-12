FactoryGirl.define do
  factory :user, aliases: [:commissioner] do
    email Forgery(:internet).email_address
    password "password"
  end  
end