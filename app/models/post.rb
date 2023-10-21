# frozen_string_literal: true

class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :chat, touch: true, counter_cache: true

  validates :body, presence: true,
                   length: { minimum: 1, allow_blank: false }

  after_create_commit :show_toast

  def short_body(count = 40)
    @short_body ||= body.size > count ? "#{body[0, count]}..." : body
  end

  private

  def show_toast
    broadcast_update_to 'global_post_notification',
                        target: 'toast',
                        partial: 'shared/toast',
                        locals: { post: self, chat:, link: chat_path(chat.id) }
  end
end
