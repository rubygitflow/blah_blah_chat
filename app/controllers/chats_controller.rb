# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :init_toast, only: %i[show index]

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
      flash[:success] = 'The Chat successfully created.'
      redirect_to @chat
    else
      flash.now[:danger] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:topic)
  end

  def init_toast
    @chat = nil
    @post = nil
  end
end
