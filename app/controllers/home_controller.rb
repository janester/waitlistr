class HomeController < ApplicationController
  def index
    @list = List.first.users.order(:position)
  end

  def add
    List.first.add_user(@current_user)
    Pusher.trigger("jane_channel", "add_to", "#{@current_user.username}")
    render :nothing => true
  end

  def remove_check
    if @current_user.username == params[:username]
      response = true
    else
      response = false
    end
    render :json => {response:response, username:params[:username]}
  end

  def remove
    @current_user.list = nil
    @current_user.save
    Pusher.trigger("jane_channel", "remove_from", "#{@current_user.username}")
    render :nothing => true
  end
end
