# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :chat, touch: true

  validates :body, presence: true,
                   length: { minimum: 1, allow_blank: false }

  after_create_commit :show_toast

  private

  def show_toast
    broadcast_update_to 'global_post_notification',
                        target: 'toast',
                        partial: 'shared/toast',
                        locals: { post: self, chat: }
  end
end
