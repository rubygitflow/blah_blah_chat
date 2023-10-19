# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :init_toast, only: %i[show index]
  before_action :find_chat, only: %i[show edit update destroy]

  def index
    @chats = Chat.order(updated_at: :desc)
  end

  def show
    @chat.posts_count!
    @posts = @chat.posts.order(created_at: :desc) if @chat
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)

    if @chat&.save
      flash[:success] = 'The Chat successfully created.'
      redirect_to @chat
    else
      flash.now[:danger] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @chat&.update(chat_params)
      redirect_to chats_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chat&.destroy
    flash.now[:success] = "Chat \"#{@chat.topic}\" deleted!" if @chat&.destroyed?
  end

  private

  def find_chat
    @chat = Chat.find_by(id: params[:id])
  end

  def chat_params
    params.require(:chat).permit(:topic)
  end

  def init_toast
    @chat = nil
    @post = nil
  end
end
