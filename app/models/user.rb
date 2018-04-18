class User < ApplicationRecord
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"
  belongs_to :language
  validates_presence_of :name, :username, :password
  validates :username, uniqueness: true, length: { in: 6..20 }
  validates :password, length: { in: 6..20 }
  has_secure_password

  def chatrooms
    if Chatroom.all.length > 0
      Chatroom.all.select{|chat|
        chat.messages.last.recipient == self || chat.messages.last.sender == self
      }
    else
      []
    end
  end

end
