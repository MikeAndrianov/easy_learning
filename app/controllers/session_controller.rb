class SessionController < Devise::SessionsController
  before_filter :set_the_header
  
  private

  def set_the_header
    @the_header = :users
  end

end
