class CoursesController < ApplicationController

	before_filter :validate_role
	before_filter :set_the_header

	def show
		@course = Course.find_by(id: params[:id])
		@groups = Group.all
	end

	def index
		@courses = Course.paginate(:page => params[:page], :per_page => 20)
	end

	def create
		course = Course.create(course_params)
		redirect_to course_path(course)
	end

	def update
		@course = Course.find(params[:id])
		if params[:group_id]
			group = Group.find(params[:group_id])
			if @course.groups.include? group
				@course.groups.delete(group)
			else
				@course.groups << group
			end
		end
		render nothing: true
	end

	def validate_role
		redirect_to root_url unless admin? || lecturer?
	end

	def course_params
		params.require(:course).permit(:name, :lecturer_id)
	end

	def set_the_header
    @the_header = :settings
  end

end