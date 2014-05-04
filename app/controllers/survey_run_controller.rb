class SurveyRunController < ApplicationController
  before_filter :set_the_header
  before_filter :set_user

  def run
    @survey=Survey.find(params[:survey_id])
  end

  def calc_result
  end

  private
 
  def set_the_header
    @the_header = :schedule
  end
   
  def set_user
    @user = current_user
  end
end
