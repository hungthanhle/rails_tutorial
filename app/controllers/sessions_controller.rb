class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to forwarding_url || user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
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

  def google
    # render html: 'hello'
    # render json: request.env['omniauth.auth']
    auth_hash = request.env['omniauth.auth']
    email = auth_hash.info.email
    google_id = auth_hash.uid
    name = auth_hash.info.name
    user = User.find_or_create_by(email:, google_id:)
    if user
      if !user.activated?
        user.update_attribute(:name, name)
        user.update_attribute(:activated, true)
      end
      forwarding_url = session[:forwarding_url]
      reset_session
      log_in user
      cookies[:remember_me]  == '1' ? remember(user) : forget(user)
      cookies.delete :remember_me
      redirect_to forwarding_url || user
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
