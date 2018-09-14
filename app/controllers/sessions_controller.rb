class SessionsController < ApplicationController
  def create 
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password]}
    login!(@user)
    redirect_to user_url(@user)
  end 
  def new
    render :new 
  end 
  def destroy
      current_user.reset_session_token!
      session[:session_token] = nil
  end
end