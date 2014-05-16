class SurveyRunController < ApplicationController
  before_filter :set_the_header
  before_filter :set_user

  def run
    @survey=Survey.find(params[:survey_id])
  end

  def calc_result
    @survey=Survey.find(params[:survey_id])
    result=0
    # calc result score
    survey_params[:questions_attributes].each do |key, question|
      qScore=1 # question score
      question[:answers_attributes].each do |key, answer|
        a_id=answer[:id]
        dbAnswer=Answer.find(a_id)
        is_right=dbAnswer.is_right
        is_checked=answer[:is_checked]
        if ((is_checked=='0' && is_right==true) || (is_checked=='1' && is_right==false))
          qScore=0
          break
        end
      end
      result+=qScore
      puts question      
    end
    @result=result
    @questionNumber=@survey.questions.size
    # save result to db
    @survey.survey_results.create(right_answered: result, 
      total: @questionNumber,user: @user)
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
