class SettingsController < ApplicationController
  before_filter :set_the_header

 
  def show 
  	@user = current_user
  end
  def create 
  	@user = current_user

  	if @user.save 
  		flash[:success]="Successfully edited"

  		respond_to do |format|
  			format.html {redirect_to :action=> :show}
  		end
  	else
  		flash[:fail]="Settings were not updated"

  		respond_to do |format|
  			format.html {redirect_to :action => :show}
      end
  	end
  end
  def update 
  	@user = current_user

  	if @user.update_attributes(params[:user].permit!)
  		flash[:success] = "Settings were successfully updated"
  		respond_to do |format|
  			format.html {redirect_to :action => :show}
  		end
  	else
  		flash[:fail] = "Settings was not updated"
  		respond_to do |format|
  			format.html {render :action => :show }
  		end
  	end
  end

  private

  def set_the_header
    @the_header = :settings
  end
end
