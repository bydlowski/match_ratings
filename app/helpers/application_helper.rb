module ApplicationHelper
  def page_id
    if id = content_for(:body_id) and id.present?
      return id
    else
      base = controller.class.to_s.gsub("Controller", '').underscore.gsub("/", '_')
      return "#{base}-#{controller.action_name}"
    end
  end

  def page_class
    controller.class.to_s.gsub("Controller", '').underscore.gsub("/", '_')+" "+content_for(:page_class)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
