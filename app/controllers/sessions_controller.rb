class SessionsController < ApplicationController

  def new
    @user = User.new()
    render :new
  end

  def create
    @user = User.find_by_credentials(credentials_params)
    if @user
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username and password. Try again!"]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end

  private
  def credentials_params
    params.require(:user).permit(:username, :password)
  end

end
