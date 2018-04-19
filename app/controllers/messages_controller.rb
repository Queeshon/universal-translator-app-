class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find(message_params[:chatroom_id])
    message = Message.new(message_params)
    #byebug
    if message.save
      ActionCable.server.broadcast 'room-#{message.chatroom_id}:messages',
        message: message,
        user: message.sender
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :recipient_id, :sender_id, :chatroom_id)
  end

end
