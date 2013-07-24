class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    set_session(@user, params[:user][:password])
    authenticate
  end
end
