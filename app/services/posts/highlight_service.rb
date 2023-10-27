# frozen_string_literal: true

module Posts
  class HighlightService < ::ApplicationService
    def initialize(chat, post)
      super
      @chat = chat
      @post = post
      @object = @post&.highlight
    end

    def call
      commit_in_transaction do
        if @object.present?
          @object.destroy
        else
          @object = @post.create_highlight!
        end
      end

      super
    end

    private

    def broadcast_call
      # путь берем из html
      # <%= turbo_stream_from(@chat, :posts) %>
      if @object&.destroyed?
        broadcast_later([@chat, :posts],
                        'posts/unhighlighted',
                        locals: { post: @post })
      else
        broadcast_later([@chat, :posts],
                        'posts/highlighted_warn',
                        locals: { post: @post })
      end
    end
  end
end
