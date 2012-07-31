class Admin::ApplicationController < ApplicationController

  before_filter :authenticate_user!
  
  private
    
    def is_admin?
      unless current_user.is_admin?
        render 'admin/site/403'
      end
    end
    
    def is_publisher?
      unless current_user.is_publisher?
        render 'admin/site/403'
      end
    end
    
    def is_editor?
      unless current_user.is_editor?
        render 'admin/site/403'
      end
    end

end