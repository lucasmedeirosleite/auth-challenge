class SessionsController < Devise::SessionsController
  def create
    flash[:alert] = 'E-mail is required'
    render :new, status: 401
  end
end
