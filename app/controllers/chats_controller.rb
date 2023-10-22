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
    # здесь будем стримить по подписке с помощью gem 'after_commit_everywhere'
    success, @chat = Chats::CreateService.call(chat_params)

    if success
      flash[:success] = 'The Chat successfully created.'
      redirect_to @chat
    else
      # flash.now[:danger] = 'Something went wrong'
      # or
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    success, @chat = Chats::UpdateService.call(@chat, chat_params)

    if success
      flash.now[:success] = 'The Chat topic successfully updated.'
    else
      # flash.now[:danger] = 'Something went wrong'
      # or
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # здесь будем стримить по подписке с помощью gem 'after_commit_everywhere'
    success = Chats::DeleteService.drop(@chat)

    if success
      flash.now[:success] = "Chat \"#{@chat.topic}\" deleted!"
    else
      head(:unprocessable_entity)
    end
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
