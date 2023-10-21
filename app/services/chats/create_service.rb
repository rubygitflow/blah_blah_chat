# frozen_string_literal: true

module Chats
  class CreateService < ::ApplicationService
    def initialize(params)
      super
      @params = params
    end

    def call
      commit_in_transaction do
        @object = Chat.build @params
        @object.save
      end

      super
    end

    private

    def broadcast_call
      # путь берем из html
      # <%= turbo_stream_from('chats') %>
      broadcast_later 'chats',
                      'chats/created',
                      locals: { chat: @object }
    end
  end
end
