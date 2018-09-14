class UsersController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.create(user_params)
    
    if @user
      # login!
      redirect_to :show 
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find_by(:id)
    render user_url(@user)
  end
  
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
