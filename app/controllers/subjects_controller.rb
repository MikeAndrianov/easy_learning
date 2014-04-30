class SubjectsController < ApplicationController
	before_filter :set_the_header
	before_filter :set_user

  load_and_authorize_resource

  def index
    @subjects=Subject.all
  end

  def show
    @subject=Subject.find(params[:id])
  end

  private

  def set_the_header
    @the_header = :schedule
  end
  
  def set_user
    @user = current_user
  end
end
