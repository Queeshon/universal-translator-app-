require 'base64'
require "easy_translate"
require 'google/cloud/translate'
require "google/cloud/speech"

class ConversationsController < ApplicationController
  before_action :get_conversation, only: [:show, :update, :destroy]
  before_action :authorized


  def new
    @conversation = Conversation.new
    @user = current_user
    @users = User.all.select { |user| user != @user }
  end

  def show
    #byebug
    @user = current_user

    project_id = "nomadic-thinker-201317"
    key_file = "keys.json"
    translate = Google::Cloud::Translate.new project: project_id, keyfile: key_file

    @translated_messages = @conversation.messages.map { |message| (translate.translate message.content, to: @user.language.code).text }
    other_user = @conversation.users.select { |key, user| user.id != @user.id }
    @recipient = other_user.values.first
  end

  def create
    @conversation = Conversation.create(conversation_params)
    if @conversation.valid?
      redirect_to conversation_path(@conversation)
    else
      flash[:errors] = @conversation.errors.full_messages
      redirect_to new_conversation_path
    end
  end

  def update
    conversation_params['messages_attributes']['0']['content']
    @conversation.update(conversation_params)
    if @conversation.valid?
      redirect_to @conversation
    else
      redirect_to @conversation
    end
  end

  def destroy
    #byebug
    @conversation.destroy
    redirect_to welcome_path
  end

    def recorded
      params.permit(:sender_id, :recipient_id,:conversation_id, :type)
      @conversation = Conversation.find(params[:conversation_id])
      @sender_id = params[:sender_id]
      @recipient_id = params[:recipient_id]
      @message = Message.new(sender_id: @sender_id, recipient_id: @recipient_id, conversation: @conversation)
    project_id = "stable-device-201314"
    language_code = current_user.language.code
    key_file = 'keys.json'
    # `cd var/folders/41/d3l522sn3zd0lbh0ssr7rfxc0000gp/T; for i in *; do ffmpeg -i "$i" -af "volume=10dB, highpass=f=180, lowpass=f=15000, equalizer=f=50:width_type=h:width=100:g=-15" -c:a libmp3lame -strict experimental -b:a 192k "${i%.webm}-ENCODED.mp3"; done`
    params[:type].tempfile.open
    mytext = params[:type].tempfile.read
    File.open("new.mp3", 'wb') { |file| file.write(mytext) }
    `cd mp3; for i in *.mp3; do ffmpeg -i "$i" -af "volume=5dB, highpass=f=180, lowpass=f=15000, equalizer=f=50:width_type=h:width=100:g=-15" -c:a libmp3lame -strict experimental -b:a 192k "${i%.mp3}-ENCODED.mp3"; done`
    `node record.js`
    audio_file_path = 'output.wav'
    language = @message.sender.language.code
    speech = Google::Cloud::Speech.new project: project_id, keyfile: key_file
    audio  = speech.audio audio_file_path, encoding:    :linear16,
                                           sample_rate: 16000,
                                           language:    language
    results = audio.recognize
    if results[0]
    text = results[0].transcript
    results.each do |result|
      puts "Transcription: #{result.transcript}"
    end
    File.delete('new.mp3')
    File.delete('new-ENCODED.mp3')
    File.delete('output.wav')
    @message.content = results[0].transcript
    @conversation.messages << @message
    if @conversation.save
      redirect_to conversation_path(@conversation)
    end
    else
      flash[:errors] = []
      flash[:errors] << "sorry please speak clearer"
      File.delete('new.mp3')
      File.delete('new-ENCODED.mp3')
      File.delete('output.wav')
      redirect_to conversation_path(@conversation)
    end

  end

private

  def conversation_params
    params.require(:conversation).permit(messages_attributes: [:content, :recipient_id, :sender_id])

  end

  def get_conversation
    @conversation = Conversation.find(params[:id])
  end

end
