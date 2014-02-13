class SettingsController < ApplicationController
  before_filter :set_the_header

   def show 
  	@user = current_user
  end

  def update 
  	@user = current_user

  	if @user.update_attributes(params[:user].permit!)
      	flash[:success] = "Settings were successfully updated"
        respond_to do |format|
        format.html {redirect_to :action=> :show}
      end
        
    else
  		flash[:fail] = "Some settings were not updated"
  		respond_to do |format|
  			format.html {render :action => :show }
  		end
  	end
  end

  def edit
    @user = current_user
  end

  def update_password
   @user = current_user

    if @user.update_attributes(user_params)
        flash[:success] = "Settings were successfully updated"
        respond_to do |format|
        format.html {redirect_to :action=> :show}
      end
        
    else
      flash[:fail] = "Some settings were not updated"
      respond_to do |format|
        format.html {render :action => :show }
      end
    end
  end

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation)
  end
  
  private

      def set_the_header
    @the_header = :settings
  end
end
