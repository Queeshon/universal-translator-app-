class User < ApplicationRecord
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"
  # has_many :initiated_conversations, through: :sent_messages, class_name: "Conversation"
  # has_many :conversations, through: :received_messages
  validates_presence_of :name, :username, :password
  validates :username, uniqueness: true, length: { in: 6..20 }
  validates :password, length: { in: 6..20 }
  has_secure_password

  def conversations
    if Conversation.all.length > 0
      Conversation.all.select{|convo|
        convo.messages.last.recipient == self || convo.messages.last.sender == self
      }
    else
      []
    end
  end

  
end
