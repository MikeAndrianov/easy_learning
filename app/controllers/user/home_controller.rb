class User::HomeController < HomeController
  
  def index
    # redirect_to account_url if current_user
  end
  

  private

  def set_the_header
    @the_header = :user_home
  end


end
