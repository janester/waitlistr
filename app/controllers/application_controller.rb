class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    if session[:uid].present?
      @current_user = User.find(session[:uid])
    else
      @current_user = nil
    end
  end
end
