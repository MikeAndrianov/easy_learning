class SettingsController < ApplicationController
  before_filter :set_the_header, :set_user

  def show 
  end

  def update    
    # Required for settings form to submit when password is left blank
    #
    if params[:user][:current_password].blank? || params[:user][:password].blank? || params[:user][:password_confirmation].blank?
      params[:user].delete(:current_password)
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if (params[:user][:current_password] ? @user.update_with_password(user_params) : @user.update_attributes(user_params))
      # Sign in the user bypassing validation in case his password changed
      #
      sign_in @user, :bypass => true
      
      flash[:success] = "Your **settings** have been **successfully updated**."
      redirect_to :action => :show
    else
      render :show
    end

  end

  
  private

  def set_user
    @user = current_user
  end

  def set_the_header
    @the_header = :settings
  end

  def user_params
    params.required(:user).permit!#(:password, :password_confirmation, :current_password)
  end
    
end
