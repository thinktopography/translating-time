class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
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

end