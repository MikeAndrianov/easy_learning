require 'spec_helper'

describe User do

		it { FactoryGirl.create(:valid_user).should be_valid }
		it { FactoryGirl.build(:valid_user, email: nil).should_not be_valid }
		it "should have role 'student'" do
			FactoryGirl.create(:valid_user).role.should eq("Student")
		end
		it "should have roles_mask 4" do
			FactoryGirl.create(:valid_user).roles_mask.should eq(4)
		end

		describe "roles mask" do
			
			describe "student should have mask 4" do
				before do
				  @user = FactoryGirl.build(:valid_user)
				  @user.roles = ["Student"]
				  @user.save
				end
				it { @user.roles_mask.should eq(4) }
			end

			describe "mask 4 should eq to student" do
				before do
				  @user = FactoryGirl.build(:valid_user)
				  @user.roles_mask = 4
				  @user.save
				end
				it { @user.roles.should eq(["Student"])}
			end

		end

end
