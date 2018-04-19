class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :conversation

  def translated_message(user)
    project_id = "nomadic-thinker-201317"
    key_file = "keys.json"
    translate = Google::Cloud::Translate.new project: project_id, keyfile: key_file
    @translated_message = (translate.translate self.content, to: user.language.code).text
  end
  
end
