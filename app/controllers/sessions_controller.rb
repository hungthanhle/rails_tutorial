class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      log_in user
      # remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to forwarding_url || user
    else
      # Create an error message.
      # chưa hiểu - phải reload mới flash, chưa hiểu assert template
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      # flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
