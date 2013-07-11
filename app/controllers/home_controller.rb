class HomeController < ApplicationController
  def index
  end

  def add
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
    Pusher.trigger("jane_channel", "remove_from", "#{@current_user.username}")
    render :nothing => true
  end
end
