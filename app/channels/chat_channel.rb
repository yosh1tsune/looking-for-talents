class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:class]}_#{params[:id]}"
  end
end
