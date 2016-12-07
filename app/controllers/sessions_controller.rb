class SessionsController < Devise::SessionsController
  def create
    if PasswordValidator.new.validate(resource_params[:password])
      super
    else
      redirect_to new_user_session_path, alert: I18n.t('devise.failure.invalid', authentication_keys: 'Email')
    end
  end
end
