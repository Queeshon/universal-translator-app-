class User < ApplicationRecord
  has_many :messages
  has_many :conversations, through: :messages
  validates_presence_of :name, :username, :password
  #validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :username, uniqueness: true, length: { in: 6..20 }
  validates :password, length: { in: 6..20 }
  has_secure_password
end
