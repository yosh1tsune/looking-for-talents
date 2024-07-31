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
      candidate: current_user.is_a?(Candidate) ? current_user : destinatary,
      websocket_uuid: messages_params[:websocket_uuid]
    )
  end

  def destinatary
    messages_params[:destinatary_class].constantize.find(messages_params[:destinatary_id])
  end

  def call_action_cable
    ActionCable.server.broadcast("chat_#{@chat.websocket_uuid}", websocket_payload)
  end

  def websocket_payload
    {
      from_type: current_user.class,
      from_id: current_user.id,
      text: @message.text,
      created_at: @message.created_at
    }
  end

  def messages_params
    params.require(:message).permit(:text, :destinatary_id, :destinatary_class, :websocket_uuid)
  end
end
