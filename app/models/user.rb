class User < ApplicationRecord
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"
  has_many :conversations, through: :sent_messages
  has_many :conversations, through: :received_messages
  validates_presence_of :name, :username, :password
  validates :username, uniqueness: true, length: { in: 6..20 }
  validates :password, length: { in: 6..20 }
  has_secure_password
end
