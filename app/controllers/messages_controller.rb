
require 'base64'
require "easy_translate"
require 'google/cloud/translate'
require "google/cloud/speech"

class MessagesController < ApplicationController
before_action :set_message, only: [:show, :edit, :update]

# save_path = Rails.root.join("public/audio")
# unless File.exists?(save_path)
#   Dir::mkdir(Rails.root.join("public/audio"))
# end
# data=params[:url]
# audio_data=Base64.decode64(data['data:audio/ogg;base64,'.length .. -1])
# File.open(save_path+"_audio", 'wb') do |f| f.write audio_data end
# current_user.user_detail.audio=File.open(save_path+"_audio")
# current_user.user_detail.audio_content_type="application/octet-stream"
#


  def index
    @messages = Message.all
  end

  def show

  end

  def record
    render 'record'
  end

  def new
    @message = Message.new
    @users = User.all
  end

  def recorded
    project_id = "stable-device-201314"
    language_code = "es"
    key_file = 'keys.json'
    # `cd var/folders/41/d3l522sn3zd0lbh0ssr7rfxc0000gp/T; for i in *; do ffmpeg -i "$i" -af "volume=10dB, highpass=f=180, lowpass=f=15000, equalizer=f=50:width_type=h:width=100:g=-15" -c:a libmp3lame -strict experimental -b:a 192k "${i%.webm}-ENCODED.mp3"; done`
    params[:type].tempfile.open
    mytext = params[:type].tempfile.read
    File.open("new.mp3", 'wb') { |file| file.write(mytext) }
    `cd mp3; for i in *.mp3; do ffmpeg -i "$i" -af "volume=5dB, highpass=f=180, lowpass=f=15000, equalizer=f=50:width_type=h:width=100:g=-15" -c:a libmp3lame -strict experimental -b:a 192k "${i%.mp3}-ENCODED.mp3"; done`
    `node record.js`



    audio_file_path = 'output.wav'

    speech = Google::Cloud::Speech.new project: project_id, keyfile: key_file
    audio  = speech.audio audio_file_path, encoding:    :linear16,
                                           sample_rate: 16000,
                                           language:    "en-US"
    results = audio.recognize
    if results[0]
    text = results[0].transcript
    results.each do |result|
      puts "Transcription: #{result.transcript}"
    end

    translate   = Google::Cloud::Translate.new project: project_id, keyfile: key_file
    translation = translate.translate text, to: language_code

    puts "Translated '#{text}' to '#{translation.text.inspect}'"
    puts "Original language: #{translation.from} translated to: #{translation.to}"
    "action cable"
    else
      puts "sorry please speak clearer"
    end
    File.delete('new.mp3')
    File.delete('new-ENCODED.mp3')
    File.delete('output.wav')
  end

  def create

    @message = Message.create(message_params)
      if @message.valid?
        redirect_to message_path(@message)
      else
        flash[:errors] = @message.errors.messages
        redirect_to new_message_path
      end
    end
private

def message_params
  params.require(:message).permit(:content, :user_id, :conversation_id)
end

def set_message
  @message = Message.find(params[:id])
end
# Audio.default_input.start do |*args|
#     File.new('')
# end
#
# sleep 5	    # Record 5 seconds of audio
# `arecord -q -d 3 -c 1 -f S16_LE -r 22050 -t wav | lame -V2 - out.mp3`
# device.stop


end
