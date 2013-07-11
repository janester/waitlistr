class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:uid] = user.id
    end
    authenticate
  end

  def destroy
    session[:uid] = nil
    authenticate
  end
end
