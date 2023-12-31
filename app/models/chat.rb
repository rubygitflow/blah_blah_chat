# frozen_string_literal: true

class Chat < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :topic, presence: true,
                    length: { in: 1..255, allow_blank: false }

  def posts_count!
    update_columns posts_count: posts.count
  end
end
