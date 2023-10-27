# frozen_string_literal: true

module Posts
  class CreateService < ::ApplicationService
    def initialize(chat, params)
      super
      @chat = chat
      @params = params
    end

    def call
      commit_in_transaction do
        @object = @chat.posts.build @params
        @object.save
      end

      super
    end

    private

    def broadcast_call
      # путь берем из html
      # <%= turbo_stream_from(@chat, :posts) %>
      broadcast_later([@chat, :posts],
                      'posts/created',
                      locals: { post: @object })
    end
  end
end
