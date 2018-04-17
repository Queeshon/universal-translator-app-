class ConversationsController < ApplicationController

  def new
    @conversation = Conversation.new
    @users = User.all
    @user = User.find_by(username: session[:username])
  end

  def show
    @conversation = Conversation.find(params[:id])
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


private
  def conversation_params
    params.require(:conversation).permit(messages_attributes: [:content, :recipient_id, :sender_id])
  end

end
