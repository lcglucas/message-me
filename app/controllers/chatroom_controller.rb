class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @message = Message.new
    @messages = Message.custom_display

    users_online = Kredis.unique_list "users_online"
    @users = User.find(users_online.elements)
  end
end
