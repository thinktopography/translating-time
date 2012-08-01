module ApplicationHelper

  def link_to_type(text, link, type)
    link_to text, link + '?type=' + type, { :class => ((params[:type] == type) ? 'selected' : '') }
  end

end