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
    @conversation = Conversation.create(conversation_params)
    if @conversation.valid?
      redirect_to conversation_path(@conversation)
    else
      flash[:errors] = @conversation.errors.full_messages
      redirect_to new_conversation_path
    end
  end


private
  def conversation_params
    params.require(:conversation).permit(:receiver_id, :initiator_id, messages_attributes:[:content])
  end

end
