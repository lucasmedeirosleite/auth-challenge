class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless session[:user_id].present?
      flash[:alert] = 'You are not logged in'
      redirect_to new_authentication_path
    end
  end
end
