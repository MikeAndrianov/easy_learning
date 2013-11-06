module ApplicationHelper

  def render_appropriate_header
    @the_header = 'unspecified' if @the_header.nil?
    render :partial => "layouts/headers/#{@the_header}" if @the_header
  end


end
