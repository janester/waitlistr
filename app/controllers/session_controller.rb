class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    set_session(user, params[:password])
    authenticate
  end

  def destroy
    session[:uid] = nil
    authenticate
  end
end
