class SurveysController < ApplicationController
  before_filter :set_the_header
  before_filter :set_user

  # I've added create to except because otherwise I get ForbiddenAttributesError on create action
  # maybe we should use workaround from here https://github.com/ryanb/cancan/issues/835
  # this is temp stub, and should be fixed!!!
  load_and_authorize_resource except: [:create]


  def index
  	@surveys=Survey.where(subject_id: params[:subject_id])
    @subject=Subject.find(params[:subject_id])
  end

  def create
    @survey = Survey.new(name: params[:survey][:name])
    @survey.save
    redirect_to surveys_path
  end  

  def destroy    
    @survey = Survey.find(params[:id])
    @survey.destroy
    redirect_to surveys_path
  end

  def edit
    #rethrow params[:id]
    session[:survey_edit_id]=params[:id]
  end

  def getSurvey
    survey=Survey.find(session[:survey_edit_id])
    render json: survey.as_json(
      include: {questions:{
        include: :answers
      }},except: [:created_at,:updated_at])
  end

  respond_to :json

  def addQuestion
    @question=Question.create!(content:params[:content],survey_id:params[:survey_id])
    respond_to do |format|
      format.json { render json: @question.id }
    end
  end

  def deleteQuestion
    Question.destroy(params[:_json])
    render :status => 200,
           :json => { :success => true}
  end

  def addAnswer
    @answer=Answer.create!(content: params[:content],question_id: params[:questionId])
    respond_to do |format|
      format.json { render json: @answer.id }
    end
  end

  def deleteAnswer
    Answer.destroy(params[:_json])
    render :status => 200,
           :json => { :success => true}
  end

  def triggerAnswer
    a=Answer.find(params[:_json])
    a.is_right=!a.is_right
    a.save!
    render :status => 200,
           :json => { :success => true}
  end

  private

  def set_the_header
    @the_header = :schedule
  end
  
  def set_user
    @user = current_user
  end

end
