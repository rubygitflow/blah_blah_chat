# frozen_string_literal: true

module Posts
  class DeleteService < ::ApplicationService
    def initialize(chat, post)
      super
      @chat = chat
      @object = post
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
      # <%= turbo_stream_from(@chat, :posts) %>
      broadcast_remove [@chat, :posts],
                       @object
    end
  end
end
