module ApplicationHelper

  def render_appropriate_header
    @the_header = 'unspecified' if @the_header.nil?
    render :partial => "layouts/headers/#{@the_header}" if @the_header
  end

  def nav_tabs(tabs=[])
    html = []
    tabs.each do |tab| 
      html << (content_tag :li, :class => ("current-page" if request.fullpath == tab[:path]) do
        link_to tab[:path] do
          content_tag(:i, '', :class => tab[:icon]) +
          tag(:br) +
          "#{tab[:name]}"
        end
      end)    
    end
    
    html.join.html_safe
  end

end
