require 'spec_helper'

describe SessionsController do

	before do
		@request.env["devise.mapping"] = Devise.mappings[:user]
	end

	describe "Sign in Student" do
		
		before do
		  user_attr = FactoryGirl.attributes_for(:student)
    	@user = User.create user_attr
		end

		describe "successful" do
			before { post :create, user: { email: @user.email, password: @user.password }}
			it { should redirect_to(user_student_root_path) }
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

	describe "Sign in Admin" do
		before do
		  admin_attr = FactoryGirl.attributes_for(:admin)
    	@admin = User.create admin_attr
		end
		describe "successful" do
			before { post :create, user: { email: @admin.email, password: @admin.password }}
			it { should redirect_to(user_admin_root_path) }
			it { controller.current_user.id.should eq(@admin.id) }
		end
	end

	describe "Sign in Lecturer" do
		before do
		  lect_attr = FactoryGirl.attributes_for(:lecturer)
    	@lect = User.create lect_attr
		end
		describe "successful" do
			before { post :create, user: { email: @lect.email, password: @lect.password }}
			it { should redirect_to(user_lecturer_root_path) }
			it { controller.current_user.id.should eq(@lect.id) }
		end
	end

end
