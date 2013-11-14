module ApplicationHelper

  def render_appropriate_header
    @the_header = 'unspecified' if @the_header.nil?
    render :partial => "layouts/headers/#{@the_header}" if @the_header
  end

  def nav_tabs(tabs=[])
    html = []
    tabs.each do |tab|
      tab_class = request.fullpath == tab[:path] ? "current-page #{tab[:class]}" : tab[:class]
      html << (content_tag :li, :class => tab_class, :id => tab[:id] do
        link_to tab[:path], :method => tab[:method] do
          content_tag(:i, '', :class => tab[:icon]) +
          tag(:br) +
          "#{tab[:name]}"
        end
      end)    
    end
    
    html.join.html_safe
  end

  def clear(subclass=nil, options = {})
    subclass = ' ' + subclass unless subclass.blank?
    styles = []
    styles << "height:#{options[:height]}px" unless options[:height].blank?

    options[:styles].each{|prop, val| styles << "#{prop}:#{val}"} if options[:styles]
    styles_str = styles.empty? ? '' : " style=\"#{styles.join('; ')}\""
    "<div class=\"clear#{subclass}\"#{styles_str}></div>".html_safe
  end

  #
  #methods finds **substring** in given string and replace asterisks width <strong> tag 
  def make_bolder_text_part(text)
    text.gsub(/\*\*[\w\s]+\*\*/) do |bold_text_part| 
      content_tag(:strong, bold_text_part.delete("**"))
    end
  end

  def write_flash(*attrs)
    res = (attrs.blank? ? [ :fail, :warn, :success, :notice] : attrs).collect do |item|
        text = make_bolder_text_part flash[item].to_s.split("\n").collect { |text| h text }.join("<br />\n") if flash[item]
        %[<div class="alert alert-#{item}">#{text}</div>] if text
    end.compact.join + flash[:notice].to_s
    res.html_safe
  end

end
