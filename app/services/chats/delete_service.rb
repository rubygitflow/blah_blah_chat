# frozen_string_literal: true

module Chats
  class DeleteService < ::ApplicationService
    def initialize(chat)
      super
      @object = chat
    end

    def drop
      commit_in_transaction do
        @object&.destroy
      end

      super
    end

    private

    def broadcast_call
      # путь берем из html
      # <%= turbo_stream_from('chats') %>
      broadcast_remove 'chats',
                       @object
    end
  end
end
