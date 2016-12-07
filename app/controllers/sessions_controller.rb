class SessionsController < Devise::SessionsController
  def create
    unless PasswordValidator.new.validate(resource_params[:password])
      flash[:alert] = 'Invalid email or password'
      redirect_to new_user_session_path, status: 401
    else
      super
    end
  end
end
