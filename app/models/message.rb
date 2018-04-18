require_relative '././translator.rb'

class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :conversation

  def translate
    @user = User.find_by(username: session[:username])
    @translation
  end
end
