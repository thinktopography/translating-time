module ApplicationHelper

  def link_to_type(text, link, type)
    link_to text, link + '?type=' + type, { :class => ((params[:type] == type) ? 'selected' : '') }
  end
  
  def link_to_tab(text, url, tabname)
    link_to text, url, :class => tabname + ((params[:tabname] == tabname) ? ' selected' : '') 
  end

  def pagerlink(text, args = {})
    klass = []
    if args.include?(:sort) && args[:sort] == params[:sort]
      args[:order] = (params[:order] == 'ASC') ? 'DESC' : 'ASC'
      klass << params[:order].downcase if params.include?(:order) 
    elsif params.include?(:order) && !args.include?(:order)
      args[:order] = params[:order] 
    end
    args[:page] = params[:page] if params.include?(:page) && !args.include?(:page)
    args[:sort] = params[:sort] if params.include?(:sort) && !args.include?(:sort)
    args[:records] = params[:records] if params.include?(:records) && !args.include?(:records)
    link_to text, url_for(params.merge(args)), :class => klass.join(' ')
  end
  
end