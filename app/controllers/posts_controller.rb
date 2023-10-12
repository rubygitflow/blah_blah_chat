# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_chat

  # def index
  #   @posts = @chat.posts
  # end

  def new
    @post = @chat.posts.new
  end

  def create
    @post = @chat.posts.new(post_params)

    if @post.save
      redirect_to chat_path(@chat.id), notice: 'Your post successfully created.'
    else
      render :new, status: :unprocessable_entity
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
