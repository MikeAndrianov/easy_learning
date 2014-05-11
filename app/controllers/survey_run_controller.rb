class SurveyRunController < ApplicationController
  before_filter :set_the_header
  before_filter :set_user

  def run
    @survey=Survey.find(params[:survey_id])
  end

  def calc_result
    @p=params
    # @s1 = Survey.new(survey_params)
    # @survey.questions.last.answers.last.attributes.each{|key, value| puts "#{key} : #{value}"}
    @survey=Survey.find(params[:survey_id])
    @survey.assign_attributes(survey_params)
    @survey.questions.last.answers.last.is_checked=true
    @survey_params=survey_params
    @is_checked=@survey.questions.last.answers.last.is_checked
  end

  private
 
  def set_the_header
    @the_header = :schedule
  end
   
  def set_user
    @user = current_user
  end

  def survey_params
    params.require(:survey).permit(questions_attributes: [:id, answers_attributes:[:id,:is_checked]])
  end
end
