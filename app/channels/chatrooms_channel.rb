class ChatroomsChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'chatrooms_channel'
  end

  def unsubscribed
  end

end
