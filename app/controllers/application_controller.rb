class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_app_name
  before_filter :set_navigation_tabs
  layout :set_layout
  helper_method :admin?, :lecturer?, :student?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:fail] = "Access denied!"
    redirect_to '/'
  end

  def account_url
    # return new_user_session_url unless user_signed_in?
    if admin?
      user_admin_schedule_url
    elsif lecturer?
      user_lecturer_schedule_url
    elsif student?
      user_student_schedule_url
    else
      root_url
    end
  end

  protected
  
  def admin?
    current_user && current_user.admin?
  end

  def lecturer?
    current_user && current_user.lecturer?
  end

  def student?
    current_user && current_user.student?
  end
  
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
    if admin?
      [
        { :name => "Administration", :icon => "glyphicon glyphicon-list-alt", :path => rails_admin.dashboard_path },
        { :name => "Files", :icon => "glyphicon glyphicon-cloud-upload", :path => user_admin_files_path },
        { :name => "Schedule", :icon => "glyphicon glyphicon-calendar", :path => user_admin_schedule_path },
        { :name => "Subjects", :icon => "glyphicon glyphicon-list", :path => subjects_path},
        { :name => "Messages", :icon => "glyphicon glyphicon-envelope", :path => inbox_user_admin_messages_path },
        { :name => "Settings", :icon => "glyphicon glyphicon-cog", :path => user_admin_settings_path },
        { :name => "Sign out", :icon => "glyphicon glyphicon-share-alt", :path => destroy_user_session_path, :method => :delete }
      ]
    elsif lecturer?
      [
        { :name => "Schedule", :icon => "glyphicon glyphicon-calendar", :path => user_lecturer_schedule_path },
        { :name => "Subjects", :icon => "glyphicon glyphicon-list", :path => subjects_path},
        { :name => "Messages", :icon => "glyphicon glyphicon-envelope", :path => inbox_user_lecturer_messages_path }, 
        { :name => "Settings", :icon => "glyphicon glyphicon-cog", :path => user_lecturer_settings_path },         
        { :name => "Sign out", :icon => "glyphicon glyphicon-share-alt", :path => destroy_user_session_path, :method => :delete }
      ]
    elsif student?
      [
        { :name => "Home", :icon => "glyphicon glyphicon-home", :path => home_index_path },
        { :name => "Schedule", :icon => "glyphicon glyphicon-calendar", :path => user_student_schedule_path },
        { :name => "Subjects", :icon => "glyphicon glyphicon-list", :path => subjects_path},
        { :name => "Messages", :icon => "glyphicon glyphicon-envelope", :path => inbox_user_student_messages_path },
        { :name => "Settings", :icon => "glyphicon glyphicon-cog", :path => user_student_settings_path },
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
