# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_chat

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
    @post = @chat.posts.find_by(id: params[:id])
    # здесь будем стримить по подписке с помощью gem 'after_commit_everywhere'
    success = Posts::DeleteService.drop(@chat, @post)

    if success
      flash.now[:success] = "Post \"#{@post.short_body(20)}\" deleted!"
    else
      head(:unprocessable_entity)
    end
  end

  private

  def find_chat
    @chat = Chat.find_by(id: params[:chat_id])
    head(:unprocessable_entity) unless @chat
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
