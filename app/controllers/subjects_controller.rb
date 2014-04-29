class SubjectsController < ApplicationController
	before_filter :set_the_header
	before_filter :set_user

  def index
    @subjects=Subject.all
  end

  private

  def set_the_header
    @the_header = :schedule
  end
  
  def set_user
    @user = current_user
  end
end
