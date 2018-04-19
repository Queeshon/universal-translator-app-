require "easy_translate"
require 'google/cloud/translate'

class ConversationsController < ApplicationController
  before_action :get_conversation, only: [:show, :update, :destroy]
  before_action :authorized

  def new
    @conversation = Conversation.new
    @user = current_user
    @users = User.all.select { |user| user != @user }
  end

  def show
    #byebug
    @user = current_user

    project_id = "nomadic-thinker-201317"
    key_file = "keys.json"
    translate = Google::Cloud::Translate.new project: project_id, keyfile: key_file

    @translated_messages = @conversation.messages.map { |message| (translate.translate message.content, to: @user.language.code).text }
    other_user = @conversation.users.select { |key, user| user.id != @user.id }
    @recipient = other_user.values.first
  end

  def create
    @conversation = Conversation.create(conversation_params)
    if @conversation.valid?
      redirect_to conversation_path(@conversation)
    else
      flash[:errors] = @conversation.errors.full_messages
      redirect_to new_conversation_path
    end
  end

  def update
    conversation_params['messages_attributes']['0']['content']
    @conversation.update(conversation_params)
    if @conversation.valid?
      redirect_to @conversation
    else
      redirect_to @conversation
    end
  end

  def destroy
    #byebug
    @conversation.destroy
    redirect_to welcome_path
  end


private

  def conversation_params
    params.require(:conversation).permit(messages_attributes: [:content, :recipient_id, :sender_id])
  end

  def get_conversation
    @conversation = Conversation.find(params[:id])
  end

end
