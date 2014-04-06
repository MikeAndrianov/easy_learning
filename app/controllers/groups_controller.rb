class GroupsController < ApplicationController

	before_filter :validate_role
	before_filter :set_the_header

	def show
		@group = Group.find(params[:id])
		@courses = Course.all
	end

	def index
		@groups = Group.paginate(:page => params[:page], :per_page => 20)
		@students = Student.where(group_id: nil, type: "Student")
	end

	def create
		group = Group.new(group_params)
		if params[:student_ids]
			params[:student_ids].each do |student|
				group.students << Student.find_by(id: student)
			end
		end
		group.save
		redirect_to group_path(group)
	end

	def update
		@group = Group.find(params[:id])
		if params[:course_id]
			course = Course.find(params[:course_id])
			if @group.courses.include? course
				@group.courses.delete(course)
			else
				@group.courses << course
			end
		end
	end

	def validate_role
		redirect_to root_url unless admin? || lecturer?
	end

	def group_params
		params.require(:group).permit(:number)
	end

	def set_the_header
    @the_header = :settings
  end

end