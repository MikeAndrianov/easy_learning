class UsersController < ApplicationController

	before_filter :validate_role
	before_filter :set_the_header

	def index
		@students = Student.paginate(:page => params[:page], :per_page => 20)
	end

	def show
		@student = Student.find_by(id: params[:id])
	end

	def update
		@student = Student.find_by(id: params[:id])
		@student.update(student_params)
		redirect_to user_path(@student)
	end

	def validate_role
		redirect_to root_url unless admin? || lecturer?
	end

	def student_params
		params.require(:student).permit(:name, :email, :mobile, :group_id)
	end

	def set_the_header
    @the_header = :settings
  end

end