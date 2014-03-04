FactoryGirl.define do

sequence(:email) { |n| "user#{n}@gmail.com" }

	factory :valid_user, class: User do
    email { generate(:email) }
    password "password"
    password_confirmation "password"
  end

end