class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: "Welcome, #{@user.name}!"
    else
      flash.alert = "Please fix the errors below to continue."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    if !current_user
      redirect_to root_path
    else
       @user = current_user
    end
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to user_path(@user)
      flash.notice = "Your profile has been updated"
    else
      flash.alert = "Please fix the errors below to continue"
      render :edit
    end
  end

  protected
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
    end
end
