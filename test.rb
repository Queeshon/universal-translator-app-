require "easy_translate"
require 'google/cloud/translate'
require 'byebug'
# EasyTranslate.api_key =
# text =
# puts EasyTranslate.translate('How many times do I need to go to the store today?', :to => :french)

# GOOGLE_APPLICATION_CREDENTIALS = "./keys.json"


project_id = "stable-device-201314"
language_code = "es"
key_file = 'keys.json'
# gcloud auth application-default login [--client-id-file='keys.json']


#########
##########
############

require "google/cloud/speech"
require 'audio'
# Audio.default_input.start do |*args|
#     File.new('')
# end
#
# sleep 5	    # Record 5 seconds of audio
# `arecord -q -d 3 -c 1 -f S16_LE -r 22050 -t wav | lame -V2 - out.mp3`
# device.stop


audio_file_path = 'output.wav'

speech = Google::Cloud::Speech.new project: project_id, keyfile: key_file
audio  = speech.audio audio_file_path, encoding:    :linear16,
                                       sample_rate: 16000,
                                       language:    "en-US"

results = audio.recognize
text = results[0].transcript
results.each do |result|

  puts "Transcription: #{result.transcript}"
end

translate   = Google::Cloud::Translate.new project: project_id, keyfile: key_file
translation = translate.translate text, to: language_code

puts "Translated '#{text}' to '#{translation.text.inspect}'"
puts "Original language: #{translation.from} translated to: #{translation.to}"
"action cable"
