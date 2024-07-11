class MessagesController < ApplicationController
  before_action :authenticate_headhunter!

  def create
    @message = chat.messages.new(text: messages_params[:text], from: sender, to: destinatary)
    @message.save!
    respond_to do |format|
      format.js
    end
  end

  private

  def chat
    @chat ||= Chat.find_or_initialize_by(
      headhunter_id: messages_params[:headhunter_id],
      candidate_id: messages_params[:candidate_id]
    )
  end

  def sender
    messages_params[:from_class].constantize.find(messages_params[:from_id])
  end

  def destinatary
    messages_params[:to_class].constantize.find(messages_params[:to_id])
  end

  def messages_params
    params.require(:message).permit(:headhunter_id, :candidate_id, :text, :from_id, :from_class, :to_id, :to_class)
  end
end
