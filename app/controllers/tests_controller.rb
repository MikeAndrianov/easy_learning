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

  def edit
    @test = Test.find(params[:id])
  end

  def destroy    
    @test = Test.find(params[:id])
    @test.destroy
    redirect_to tests_path
  end

end
