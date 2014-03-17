class TestsController < ApplicationController
  # I've added create to except because otherwise I get ForbiddenAttributesError on create action
  # maybe we should use workaround from here https://github.com/ryanb/cancan/issues/835
  # this is temp stub, and should be fixed!!!
  load_and_authorize_resource except: [:create]

  def index
  	@tests=Control.all
  end

  def create
    @test = Control.new(name: params[:test][:name]) 
    @test.save    
    redirect_to tests_path
  end  

  def destroy    
    @test = Control.find(params[:id])
    @test.destroy
    redirect_to tests_path
  end

  def edit
    #rethrow params[:id]
    session[:test_edit_id]=params[:id]
  end

  def getTest
    test=Control.find(session[:test_edit_id])
    render json: test.as_json(
      include: {questions:{
        include: :answers
      }},except: [:created_at,:updated_at])
  end

  def addQuestion
    @question=Question.create(content:params[:content],control_id:params[:test_id])
    respond_to do |format|
      format.json { render json: @question.id }
    end
  end

  def deleteQuestion

  end

end
