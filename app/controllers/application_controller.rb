class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_app_name
  before_filter :set_navigation_tabs
  layout :set_layout

  rescue_from CanCan::AccessDenied do |exception|
    flash[:fail] = "Access denied!"
    redirect_to '/'
  end

  protected

  def set_app_name
    @app_name = "EasyLearing"
  end

  def set_layout
    'application'
  end

  def set_navigation_tabs
    # We don't need this navigation tabs for admin site
    #
    return if params[:controller] == ("rails_admin/main" || "rails_admin/application")

    @tabs = 
    if current_user && current_user.admin?
      [
        { :name => "Administration", :icon => "glyphicon glyphicon-list-alt", :path => rails_admin.dashboard_path },
        { :name => "Settings", :icon => "glyphicon glyphicon-cog", :path => user_settings_path },
        { :name => "Tests", :icon => "glyphicon glyphicon-check", :path => tests_path},
        { :name => "Sign out", :icon => "glyphicon glyphicon-share-alt", :path => destroy_user_session_path, :method => :delete }
      ]
    elsif current_user && current_user.lecturer?
      [
        { :name => "Schedule", :icon => "glyphicon glyphicon-calendar", :path => user_schedule_path },
        { :name => "Tests", :icon => "glyphicon glyphicon-check", :path => tests_path},
        { :name => "Settings", :icon => "glyphicon glyphicon-cog", :path => user_settings_path },         
        { :name => "Sign out", :icon => "glyphicon glyphicon-share-alt", :path => destroy_user_session_path, :method => :delete }
      ]
    elsif current_user && current_user.student?
      [
        { :name => "Schedule", :icon => "glyphicon glyphicon-calendar", :path => user_schedule_path },
        { :name => "Event DELETE THIS!", :icon => "glyphicon glyphicon-calendar", :path => events_path },
        { :name => "Tests", :icon => "glyphicon glyphicon-check", :path => tests_path},
        { :name => "Settings", :icon => "glyphicon glyphicon-cog", :path => user_settings_path },
        { :name => "Sign out", :icon => "glyphicon glyphicon-share-alt", :path => destroy_user_session_path, :method => :delete }
      ]
    else
      [
        { :name => "Home", :icon => "glyphicon glyphicon-home", :path => home_index_path },          
        { :name => "Portfolio", :icon => "glyphicon glyphicon-picture", :path => portfolio_home_index_path },
        { :name => "Services", :icon => "glyphicon glyphicon-briefcase", :path => services_home_index_path },
        { :name => "About", :icon => "glyphicon glyphicon-font", :path => about_home_index_path },
        { :name => "Contact", :icon => "glyphicon glyphicon-envelope", :path => contact_home_index_path },
        { :name => "Sign in", :icon => "glyphicon glyphicon-user", :path => '#', :id => "sign-in" }
      ]
    end
  end

end
