require 'spec_helper'

describe SessionsController do

	before do
		@request.env["devise.mapping"] = Devise.mappings[:user]
	end

	describe "Sign in User" do
		
		before do
		  user_attr = FactoryGirl.attributes_for(:valid_user)
    	@user = User.create user_attr
		end

		describe "successful" do
			before { post :create, user: { email: @user.email, password: @user.password }}
			it { should redirect_to(root_path) }
			it { controller.current_user.id.should eq(@user.id) }
		end

		describe "wrong password" do
			before { post :create, user: { email: @user.email, password: "password123" }}
			it { response.code.should eq("200") }
      it { controller.current_user.should eq(nil) }
		end

		describe "password is empty" do
      before { post :create, user: { email: @user.email, password: '' }}
			it { response.code.should eq("200") }
			it { controller.current_user.should eq(nil) }
    end

    describe "wrong email" do
      before { post :create, user: { email: "wrong@gmail.com", password: @user.password }}
      it { response.code.should eq("200") }
      it { controller.current_user.should eq(nil) }
    end

    describe "email is empty" do
      before { post :create, user: { email: '', password: @user.password }}
      it { response.code.should eq("200") }
      it { controller.current_user.should eq(nil) }
    end

	end

end
