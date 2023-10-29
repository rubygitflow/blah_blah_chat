# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :init_toast, only: %i[show index]
  before_action :find_chat, only: %i[show edit update destroy]

  POSTS_PER_PAGE = 10
  CHATS_PER_PAGE = 10

  def index
    @cursor = params[:cursor].to_i
    @used = params[:opened].to_a
    # define @created_at To exclude newly created chats
    @created_at = (params[:newly_created_at] || Time.now).to_time
    @chats = Chat.all
                 .where.not(id: @used)
                 .where('created_at < ?', @created_at)
                 .order(updated_at: :desc)
                 .take(CHATS_PER_PAGE)
    @next_cursor = @cursor + 1
    @more_pages = @next_cursor.present? && @chats.count == CHATS_PER_PAGE
    # define @used To show updated but not presented chats
    @used += @chats.map(&:id)

    render 'index_scrollable_list' if params[:cursor]
  end

  def show
    return unless @chat

    @cursor = (params[:cursor] || ((@chat.posts.last&.id || 0) + 1)).to_i
    @posts = @chat.posts
                  .where('posts.id < ?', @cursor)
                  .includes(:highlight)
                  .order(id: :desc)
                  .take(POSTS_PER_PAGE)
    @next_cursor = @posts.last&.id
    @more_pages = @next_cursor.present? && @posts.count == POSTS_PER_PAGE

    render 'show_scrollable_list' if params[:cursor]
  end

  def new
    @chat = Chat.new
  end

  def create
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
