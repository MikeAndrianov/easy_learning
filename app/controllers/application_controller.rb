class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_app_name
  before_filter :set_navigation_tabs
  layout :set_layout

  protected

  def set_app_name
    @app_name = "EasyLearing"
  end

  def set_layout
    'application'
  end

  def set_navigation_tabs
    @tabs = 
      if current_user && current_user.admin?
        [
          { :name => "Users", :icon => "icon-user", :path => user_settings_path },
          { :name => "Settings", :icon => "icon-cog", :path => user_settings_path },
          { :name => "Sign out", :icon => "icon-share-alt", :path => destroy_user_session_path, :method => :delete }
        ]
      elsif current_user && current_user.lecturer?
        [
          { :name => "Settings", :icon => "icon-cog", :path => user_settings_path },
          { :name => "Sign out", :icon => "icon-share-alt", :path => destroy_user_session_path, :method => :delete }
        ]
      elsif current_user && current_user.student?
        [
          { :name => "Settings", :icon => "icon-cog", :path => user_settings_path },
          { :name => "Sign out", :icon => "icon-share-alt", :path => destroy_user_session_path, :method => :delete }
        ]
      else
        [
          { :name => "Home", :icon => "icon-home", :path => home_index_path },
          { :name => "Portfolio", :icon => "icon-camera", :path => portfolio_home_index_path },
          { :name => "Services", :icon => "icon-tasks", :path => services_home_index_path },
          { :name => "About", :icon => "icon-font", :path => about_home_index_path },
          { :name => "Contact", :icon => "icon-envelope-alt", :path => contact_home_index_path },
          { :name => "Sign in", :icon => "icon-user", :path => '#', :id => "sign-in" }
        ]
      end
  end

end
