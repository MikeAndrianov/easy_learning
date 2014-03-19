FactoryGirl.define do

sequence(:email) { |n| "user#{n}@gmail.com" }
sequence(:name) { |n| "user#{n}" }

	factory :student, class: User do
    email { generate(:email) }
    name { generate(:name) }
    password "password"
    password_confirmation "password"
    type "Student"

    factory :admin do
	    type "Admin"
	  end

		factory :lecturer do
	    type "Lecturer"
	  end
  end
end