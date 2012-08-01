class Admin::ApplicationController < ApplicationController

  before_filter :authenticate_user!
  before_filter :change_password
  
  private
    
    def change_password
      if user_signed_in? && current_user.change_password && !['password'].include?(self.controller_name)
        session["user_return_to"] = request.env["REQUEST_PATH"]
        redirect_to new_admin_password_path
      end
    end
    
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