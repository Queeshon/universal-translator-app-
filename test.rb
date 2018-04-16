require "easy_translate"
require 'google/cloud/translate'
# EasyTranslate.api_key = 'AIzaSyDMyqiBkTe3EbbeFv2ge0GW7ZZRD5dfEFo'
# text =
# puts EasyTranslate.translate('How many times do I need to go to the store today?', :to => :french)

# GOOGLE_APPLICATION_CREDENTIALS = "./keys.json"

# api_key = 'AIzaSyDMyqiBkTe3EbbeFv2ge0GW7ZZRD5dfEFo'
project_id = "stable-device-201314"
text = "Hello World"
language_code = "es"
# gcloud auth application-default login [--client-id-file='keys.json']
translate   = Google::Cloud::Translate.new project: project_id
translation = translate.translate text, to: language_code

puts "Translated '#{text}' to '#{translation.text.inspect}'"
puts "Original language: #{translation.from} translated to: #{translation.to}"


"action cable"
