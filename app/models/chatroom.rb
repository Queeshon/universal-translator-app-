class Chatroom < ApplicationRecord
  has_many :messages, dependent: :delete_all
  # has_many :users, through: :messages
  accepts_nested_attributes_for :messages

  def users
    users = {}
    users[:recipient] = self.messages.first.recipient
    users[:sender] = self.messages.first.sender
    users
  end

  def sender
    users[:sender]
  end

  def recipient
    users[:recipient]
  end
end
