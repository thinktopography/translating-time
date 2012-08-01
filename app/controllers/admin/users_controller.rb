class Admin::UsersController < Admin::ApplicationController

  before_filter :is_admin?

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user, :bypass => true) if(@user.id == current_user.id)
      flash[:success] = 'The user was successfully created'
      redirect_to admin_users_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'The user was successfully updated'
      redirect_to admin_users_path
    else
      flash[:error] = 'There were problems with your input'
      render :action => 'edit'
    end
  end
  
  def reset
    @user = User.find(params[:id])
    @user.reset_password
    flash[:success] = "This user's password was successfully reset"
    redirect_to admin_users_path
  end

end