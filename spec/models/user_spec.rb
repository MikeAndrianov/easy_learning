require 'spec_helper'

describe User do
	describe "factories" do
		it { FactoryGirl.create(:student).should be_valid }
		it { FactoryGirl.build(:student, email: nil).should_not be_valid }
		it { FactoryGirl.create(:student).type.should eq("Student") }
		it { FactoryGirl.create(:lecturer).type.should eq("Lecturer") }
		it { FactoryGirl.create(:admin).type.should eq("Admin") }
	end
end
