class Admin::PasswordsController < Admin::ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.change_password = false
    if @user.update_attributes(allowed_params)
      sign_in(@user, :bypass => true)
      flash[:success] = 'Your password has been reset'
      redirect_to admin_dashboard_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end
  
  private 
  
    def allowed_params
      params.require(:user).permit([:password, :password_confirmation])
    end

end