class ChatsController < ApplicationController
  before_action :authenticate_headhunter!

  def new
    @chat = Chat.new(headhunter_id: chat_params[:headhunter], candidate_id: chat_params[:candidate])
    @destinatary = destinatary
    respond_to do |format|
      format.js
    end
  end

  private

  def destinatary
    id = if chat_params[:destinatary] == 'Candidate'
           chat_params[:candidate]
         elsif chat_params[:destinatary] == 'Headhunter'
           chat_params[:headhunter]
         end

    chat_params[:destinatary].constantize.find(id)
  end

  def chat_params
    params.permit(:headhunter, :candidate, :destinatary)
  end
end
