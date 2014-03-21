class UsersController < ApplicationController

	before_filter :validate_role

	def index
		@students = Student.paginate(:page => params[:page], :per_page => 20)
	end

	def show
		@student = Student.find_by(id: params[:id])
	end

	def validate_role
		redirect_to root_url unless admin? || lecturer?
	end

end