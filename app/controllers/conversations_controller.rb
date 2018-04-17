class ConversationsController < ApplicationController

  def new
    @conversation = Conversation.new
    @users = User.all
    @user = User.find_by(username: session[:username])
  end

  def show
    @user = User.find_by(username: session[:username])
    @conversation = Conversation.find(params[:id])
    other_user = @conversation.users.select { |key, user| user.id != @user.id }
    #byebug
    @recipient = other_user.values.first
    #byebug
  end

  def create
    #byebug
    # @message = Message.new(conversation_params[:messages_attributes]["0"])
    @conversation = Conversation.create(conversation_params)
    # @conversation.messages << @message
    # @conversation.save
    # @user.sent_messages >> @conversation.messages.last
    if @conversation.valid?
      redirect_to conversation_path(@conversation)
    else
      flash[:errors] = @conversation.errors.full_messages
      redirect_to new_conversation_path
    end
  end

  def update
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

end
