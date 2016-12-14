class AuthenticationController < ApplicationController
  def new
    @user = User.new
  end

  def sign_in
    @user = User.new(user_params)
    if Authenticator.call(@user.email, @user.password)
      session[:user_id] = User.find_by(email: @user.email).id
      flash[:notice] = 'Signed in successfully'
      redirect_to root_path
    else
      flash[:alert] = 'Authentication failed'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
