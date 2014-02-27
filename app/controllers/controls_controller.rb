class TestsController < ApplicationController
  # I've added create to except because otherwise I get ForbiddenAttributesError on create action
  # maybe we should use workaround from here https://github.com/ryanb/cancan/issues/835
  # this is temp stub, and should be fixed!!!
  load_and_authorize_resource except: [:create]

  def index
  	@controls=Control.all
  end

  def create
    @control = Control.new(name: params[:control][:name]) 
    @control.save    
    redirect_to controls_path
  end  

  def destroy    
    @control = Control.find(params[:id])
    @control.destroy
    redirect_to controls_path
  end

  def edit
    #rethrow params[:id]
    session[:control_edit_id]=params[:id]
  end

  def getTest
    control=Control.find(session[:control_edit_id])
    render json: control.as_json(
      include: {questions:{
        include: :answers
      }},except: [:created_at,:updated_at])
  end

  def addQuestion
    @question=Question.create(content:params[:content],control_id:params[:control_id])
    respond_to do |format|
      format.json { render json: @question.id }
    end
  end

  def deleteQuestion

  end

end
