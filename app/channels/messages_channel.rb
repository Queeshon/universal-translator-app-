class MessagesChannel < ApplicationCable::Channel

  def subscribed
    #chatroom = Chatroom.find(params[:chatroom])
    stream_from "room-#{params['room']}:messages"
  end

  def unsubscribed

  end

  def receive(payload)
    Message.create(user: current_user, chatroom_id: params["room"], content: payload["message"])
  end

end
