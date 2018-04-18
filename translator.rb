require "easy_translate"
require 'google/cloud/translate'


project_id = "nomadic-thinker-201317"
key_file = "keys.json"


translate = Google::Cloud::Translate.new project: project_id, keyfile: key_file
@translation = translate.translate self.content, to: @user.language.code
