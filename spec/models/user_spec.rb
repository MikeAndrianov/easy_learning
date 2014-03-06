require 'spec_helper'

describe User do
	describe "factories" do
		it { FactoryGirl.create(:student).should be_valid }
		it { FactoryGirl.build(:student, email: nil).should_not be_valid }
		it { FactoryGirl.build(:student, name: nil).should_not be_valid }
		it { FactoryGirl.create(:student).type.should eq("Student") }
		it { FactoryGirl.create(:lecturer).type.should eq("Lecturer") }
		it { FactoryGirl.create(:admin).type.should eq("Admin") }
	end

	describe "type methods" do
		before do
		  @admin = FactoryGirl.create(:admin)
		  @lecturer = FactoryGirl.create(:lecturer)
		  @student = FactoryGirl.create(:student)
		end
		it { @admin.admin?.should eq(true) }
		it { @lecturer.lecturer?.should eq(true) }
		it { @student.student?.should eq(true) }
		it { @student.lecturer?.should eq(false) }
		it { @student.admin?.should eq(false) }
	end

end
