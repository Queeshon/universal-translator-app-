require "easy_translate"
require 'google/cloud/translate'

class ConversationsController < ApplicationController

  def new
    @conversation = Conversation.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = current_user

    project_id = "nomadic-thinker-201317"
    key_file = "keys.json"
    translate = Google::Cloud::Translate.new project: project_id, keyfile: key_file

    @conversation = Conversation.find(params[:id])
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
    @conversation = Conversation.find(params[:id])
    @conversation.update(conversation_params)
    if @conversation.valid?
      redirect_to @conversation
    else
      redirect_to @conversation
    end
  end


private
  def conversation_params
    params.require(:conversation).permit(messages_attributes: [:content, :recipient_id, :sender_id])
  end

  def translate
    project_id = "nomadic-thinker-201317"
    key_file = "keys.json"

    translate = Google::Cloud::Translate.new project: project_id, keyfile: key_file
    @translation = translate.translate self.content, to: @user.language.code

    @translation
  end

end
