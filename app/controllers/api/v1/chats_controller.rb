# frozen_string_literal: true

module Api
  module V1
    class ChatsController < ApiController
      def index
        @chats = Chat.order(created_at: :desc)
        render json: { items: @chats, items_count: @chats.size }
      end
    end
  end
end
