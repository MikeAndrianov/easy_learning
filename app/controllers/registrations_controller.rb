class RegistrationsController < Devise::RegistrationsController
  before_filter :set_the_header
  before_filter :user_params, :only => [:update, :create]

  def create
    # only Students can register from home page
    #
    build_resource(sign_up_params.merge(:role => "Student"))

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :success, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :fail, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end


  private

  def set_the_header
    @the_header = :users
  end

  def user_params
    devise_parameter_sanitizer.for(:sign_up)
  end


end
