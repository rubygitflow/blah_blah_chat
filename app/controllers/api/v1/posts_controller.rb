# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      before_action :find_chat

      def create
        success, @post = Posts::CreateService.call(@chat, post_params)

        if success
          render json: { post: @post }, status: :created
        else
          render json: { errors: @post.errors }, status: :unprocessable_entity
        end
      end

      private

      def find_chat
        @chat = Chat.find_by(id: params[:chat_id])
        render json: { errors: ['No chat by id found'] }, status: :unprocessable_entity unless @chat
      end

      def post_params
        params.require(:post).permit(:body)
      end
    end
  end
end
