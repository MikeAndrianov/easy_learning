class TestsController < ApplicationController
  # I've added create to except because otherwise I get ForbiddenAttributesError on create action
  # maybe we should use workaround from here https://github.com/ryanb/cancan/issues/835
  # this is temp stub, and should be fixed!!!
  load_and_authorize_resource except: [:create]

  def index
  	@tests=Test.all
  end

  def create
    @test = Test.new(name: params[:test][:name]) 
    @test.save    
    redirect_to tests_path
  end  

  def destroy    
    @test = Test.find(params[:id])
    @test.destroy
    redirect_to tests_path
  end

  def edit
    #rethrow params[:id]
    session[:test_edit_id]=params[:id]
  end

  def getTest
    test=Test.find(session[:test_edit_id])
    render json: test.as_json(
      include: {questions:{
        include: :answers
      }},except: [:created_at,:updated_at])
  end

  respond_to :json

  def addQuestion
    @question=Question.create(content:params[:content],test_id:params[:test_id])
    respond_to do |format|
      format.json { render json: @question.id }
    end
  end

  def deleteQuestion
    @q=Question.destroy(params[:_json])
    render :status => 200,
           :json => { :success => true}
  end

  def addAnswer
    @answer=Answer.create(content: params[:content],question_id: params[:questionId])
    respond_to do |format|
      format.json { render json: @answer.id }
    end
  end

end
