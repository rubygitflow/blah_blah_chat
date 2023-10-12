# frozen_string_literal: true

module Api
  module V1
    class ChatsController < ApplicationController
      def index
        @chats = Chat.order(:created_at)
        render json: { chats: @chats }
      end
    end
  end
end
