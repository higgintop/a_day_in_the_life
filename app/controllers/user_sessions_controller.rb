class UserSessionsController < ApplicationController
  def new
    puts "IN NEW"
    @user = User.new
  end

  def create
    puts "IN CREATE"
    if @user = login(params[:user][:email], params[:user][:password])
      redirect_to root_path, notice: "Welcome back, #{@user.name}"
    else
      @user = User.new(email: params[:user][:email])
      flash.alert = "We could not sign you in. Please check your email/password and try again."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "You have been signed out."
  end
end
