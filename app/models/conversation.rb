class Conversation < ApplicationRecord
  has_many :messages
  has_many :users, through: :messages
  accepts_nested_attributes_for :messages

  # def users_in_chat
  #   conversations.users.length
  # end
end
