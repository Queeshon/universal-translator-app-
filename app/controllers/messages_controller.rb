class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find(message_params[:chatroom_id])
    message = Message.new(message_params)
    #byebug
    message.sender = current_user
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.content,
        user: message.sender.username
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :recipient_id, :sender_id, :chatroom_id)
  end

end
