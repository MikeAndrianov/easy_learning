class HomeController < ApplicationController
  before_filter :set_the_header
  
  def index
    @users = User.all
  end

  [:about, :contact, :services, :portfolio].each do |action_name| 
    define_method(action_name){}
  end

  private

  def set_the_header
    @the_header = :home
    @tabs = [
      { :name => "Home", :icon => "icon-home", :path => home_index_path },
      { :name => "Portfolio", :icon => "icon-camera", :path => portfolio_home_index_path },
      { :name => "Services", :icon => "icon-tasks", :path => services_home_index_path },
      { :name => "About", :icon => "icon-font", :path => about_home_index_path },
      { :name => "Contact", :icon => "icon-envelope-alt", :path => contact_home_index_path },
      { :name => "Sign in", :icon => "icon-user", :path => '#', :id => "sign-in" }
    ]
  end


end
