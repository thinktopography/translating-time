module SiteHelper
  
  def format_value(value)
    unless value.blank?
      (value < 10) ? value.round(1) : value.round
    else
      value
    end
  end
  
end
