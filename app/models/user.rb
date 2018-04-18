class User < ApplicationRecord
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"
  validates_presence_of :name, :username, :password
  validates :username, uniqueness: true, length: { in: 6..20 }
  validates :password, length: { in: 6..20 }
  has_secure_password

  def conversations
    if Conversation.all.length > 0
      Conversation.all.select{|convo|
        convo.messages && convo.messages.length > 0 && convo.messages.last.recipient == self || convo.messages && convo.messages.length > 0 && convo.messages.last.sender == self

      }
    else
      []
    end
  end


end
