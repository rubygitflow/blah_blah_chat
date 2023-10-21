# frozen_string_literal: true

module Chats
  class UpdateService < ::ApplicationService
    def initialize(chat, params)
      super
      @object = chat
      @params = params
    end

    def call
      commit_in_transaction do
        @object&.update(@params)
      end

      super
    end

    private

    def broadcast_call
      # путь берем из html
      # <%= turbo_stream_from('chats') %>
      broadcast_later 'chats',
                      'chats/updated',
                      locals: { chat: @object }
    end
  end
end
