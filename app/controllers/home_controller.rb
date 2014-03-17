class HomeController < ApplicationController
  before_filter :set_the_header
  
  def index
    redirect_to account_url if current_user
  end

  [:about, :contact, :services, :portfolio].each do |action_name| 
    define_method(action_name){}
  end

  private

  def set_the_header
    @the_header = :home
  end


end
