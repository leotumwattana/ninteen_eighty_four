class ApplicationController < ActionController::Base

  CONFIRM_EMAIL_NOTICE = "Sign up successful. Please check your email to confirm your account."
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :make_action_mailer_user_request_host_and_protocol

  def is_authenticated?
    # redirect_to login_url if session[:user_id].nil?
    redirect_to login_url unless current_user
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def log_user_in(user, notice = nil)
    if user
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to bmail_index_url, notice: notice
      else
        redirect_to root_url, notice: CONFIRM_EMAIL_NOTICE
      end
    end
  end

  def log_user_out
    session[:user_id] = nil
    redirect_to root_url, notice: "You've successfully logged out."
  end

  private

  def make_action_mailer_user_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

end
