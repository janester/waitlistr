class HomeController < ApplicationController
  def index
  end

  def add
    Pusher.trigger("jane_channel", "add_to", "#{@current_user.username}")
    render :nothing => true
  end
end
