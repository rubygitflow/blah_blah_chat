# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :ensure_frame_response, only: [:new]
  before_action :find_chat
  before_action :find_post, only: %i[highlight destroy]

  def new
    @post = @chat.posts.build
  end

  def create
    # здесь надо стримить по подписке через callback модели Post
    # но воспользуемся gem 'after_commit_everywhere'
    success, @post = Posts::CreateService.call(@chat, post_params)

    if success
      flash.now[:success] = 'Your Post successfully created.'
    else
      # flash.now[:danger] = 'Something went wrong'
      # or
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # здесь будем стримить по подписке с помощью gem 'after_commit_everywhere'
    success = Posts::DeleteService.drop(@chat, @post)

    if success
      flash.now[:success] = "Post \"#{@post.short_body(20)}\" deleted!"
    else
      head(:unprocessable_entity)
    end
  end

  def highlight
    success, @highlight = Posts::HighlightService.call(@chat, @post)

    return if success

    head(:unprocessable_entity)
  end

  private

  def find_post
    @post = @chat.posts.find_by(id: params[:id])
    head(:unprocessable_entity) unless @post
  end

  def find_chat
    @chat = Chat.find_by(id: params[:chat_id])
    head(:unprocessable_entity) unless @chat
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
