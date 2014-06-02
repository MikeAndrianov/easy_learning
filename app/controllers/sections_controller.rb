class SectionsController < ApplicationController
  before_filter :set_the_header
  before_filter :set_user

  def index
    @subject=Subject.find(params[:subject_id])
    @sections=@subject.sections
  end

  private

    def set_the_header
      @the_header = :schedule
    end
    
    def set_user
      @user = current_user
    end
end
