class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, alert: 'Signed up'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    else
      flash[:alert] = "User not successfully updated."
      render :edit
    end
  end

  def edit

    @user = User.find(params[:id])

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access!"
      redirect_to new_session_path
    end
  end

end
