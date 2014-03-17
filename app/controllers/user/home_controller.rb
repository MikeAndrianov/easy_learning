class User::HomeController < HomeController
  
  def index
   # redirect_to user_schedule_path
  end
  

  private

  def set_the_header
    @the_header = :user_home
  end


end
