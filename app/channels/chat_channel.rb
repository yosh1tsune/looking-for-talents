class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:id]}"
  end
end
