class AuthenticationController < ApplicationController
  def new
  end

  def sign_in
    if Authenticator.call(user_params[:email], user_params[:password])
      session[:user_id] = User.find_by(email: user_params[:email]).id
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
