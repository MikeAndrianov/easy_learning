require 'spec_helper'

describe RegistrationsController do
	
	before do
		@request.env["devise.mapping"] = Devise.mappings[:user]
	end
	
	describe "Sign up" do

		# Is it OK that after successfully signing up there are several redirects?
		# ( home#index -> user/home#index -> schedules#show )
		#
		describe "valid" do
			before do
				@count = User.count
				user_attr = FactoryGirl.attributes_for(:valid_user)
    		post :create, user: user_attr
			end
			it { should redirect_to(root_path) }
			it { User.count.should eq( @count+1)  }
		end

		describe "invalid" do

			describe "different passwords" do
				before do
				  @count = User.count
				  post :create, user: { email: "user@gmail.com", password: "password", 
				  	password_confirmation: "passwora" }
				end
				it { response.code.should eq("200") }
				it { User.count.should be(@count) }
			end

			describe "short password" do
				before do
				  @count = User.count
				  post :create, user: { email: "user@gmail.com", password: "pass", password_confirmation: "pass" }
				end
				it { response.code.should eq("200") }
				it { User.count.should be(@count) }
			end

			describe "long password" do
				before do
				  @count = User.count
				  post :create, user: { email: "user@gmail.com", password: "password"*20, 
				  	password_confirmation: "password"*20 }
				end
				it { response.code.should eq("200") }
				it { User.count.should be(@count) }
			end

			describe "empty password" do
				before do
				  @count = User.count
				  post :create, user: { email: "user@gmail.com", password: "", password_confirmation: "" }
				end
				it { response.code.should eq("200") }
				it { User.count.should be(@count) }
			end

			describe "empty email" do
				before do
					@count = User.count
					user_attr = FactoryGirl.attributes_for(:valid_user, email: "")
	    		post :create, user: user_attr
				end
				it { response.code.should eq("200") }
				it { User.count.should be(@count) }
			end

			describe "already existing" do
				before do
				  user_attr = FactoryGirl.attributes_for(:valid_user)
	    		post :create, user: user_attr
	    		@count = User.count
	    		post :create, user: user_attr
			end
				# it { response.code.should eq("200") }
				it { User.count.should be(@count) }
			end

		end
	end

end
