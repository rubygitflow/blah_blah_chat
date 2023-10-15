# frozen_string_literal: true

class ChatsController < ApplicationController
  def index
    @chats = Chat.order(updated_at: :desc)
  end

  def show
    @chat = Chat.find_by(id: params[:id])
    @posts = @chat.posts.order(created_at: :desc) if @chat
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      redirect_to @chat, notice: 'Your chat successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:topic)
  end
end
