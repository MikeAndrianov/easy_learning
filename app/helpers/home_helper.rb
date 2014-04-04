module HomeHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def faculty_name
  	Faculty.find_by(:subdomain => request.subdomain).try(:name)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
