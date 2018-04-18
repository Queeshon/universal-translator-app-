require "easy_translate"
require 'google/cloud/translate'

class ChatroomsController < ApplicationController
  before_action :get_chatroom, only: [:show, :update, :destroy]

  def new
    @chatroom = Chatroom.new
    @user = current_user
    @users = User.all.select { |user| user != @user }
  end

  def show
    @user = current_user
    @message = Message.new

    project_id = "nomadic-thinker-201317"
    key_file = "keys.json"
    translate = Google::Cloud::Translate.new project: project_id, keyfile: key_file

    @translated_messages = @chatroom.messages.map { |message| (translate.translate message.content, to: @user.language.code).text }
    other_user = @chatroom.users.select { |key, user| user.id != @user.id }
    @recipient = other_user.values.first
    #byebug
  end

  def create
    @chatroom = Chatroom.create(chatroom_params)
    if @chatroom.valid?
      redirect_to @chatroom
    else
      flash[:errors] = @chatroom.errors.full_messages
      redirect_to new_chatroom_path
    end
  end

  def update
    chatroom_params['messages_attributes']['0']['content']
    @chatroom.update(chatroom_params)
    if @chatroom.valid?
      redirect_to @chatroom
    else
      redirect_to @chatroom
    end
  end

  def destroy
    #byebug
    @chatroom.destroy
    redirect_to welcome_path
  end


private

  def chatroom_params
    params.require(:chatroom).permit(messages_attributes: [:content, :recipient_id, :sender_id])
  end

  def get_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

end
