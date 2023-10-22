# frozen_string_literal: true

class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :chat, touch: true, counter_cache: true

  validates :body, presence: true,
                   length: { minimum: 1, allow_blank: false }

  after_create_commit :show_toast

  after_commit :send_html_counter, on: %i[create destroy]

  def short_body(count = 40)
    @short_body ||= body.size > count ? "#{body[0, count]}..." : body
  end

  private

  def send_html_counter
    broadcast_update_to 'chat_posts_count',
                        target: "chat_#{chat.id}_posts_count",
                        html: "(#{chat.posts_count})"
  end

  def show_toast
    broadcast_update_to 'global_post_notification',
                        target: 'toast',
                        partial: 'shared/toast',
                        locals: { post: self, chat:, link: chat_path(chat.id) }
  end
end
