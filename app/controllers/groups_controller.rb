class GroupsController < ApplicationController

	before_filter :validate_role

	def show
		@group = Group.find(params[:id])
		@courses = Course.all
	end

	def index
		@groups = Group.paginate(:page => params[:page], :per_page => 20)
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

end