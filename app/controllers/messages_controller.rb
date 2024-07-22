class MessagesController < ApplicationController
  def create
    @message = chat.messages.new(text: messages_params[:text], from: current_user, to: destinatary)
    @message.save!
    call_action_cable
    respond_to { |format| format.js }
  end

  private

  def chat
    @chat ||= Chat.find_or_initialize_by(
      headhunter: current_user.is_a?(Headhunter) ? current_user : destinatary,
      candidate: current_user.is_a?(Candidate) ? current_user : destinatary
    )
  end

  def destinatary
    messages_params[:destinatary_class].constantize.find(messages_params[:destinatary_id])
  end

  def call_action_cable
    ChatChannel.broadcast_to(@chat, @message)
  end

  def messages_params
    params.require(:message).permit(:text, :destinatary_id, :destinatary_class)
  end
end
