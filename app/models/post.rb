# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :chat

  validates :body, presence: true,
                   length: { minimum: 1, allow_blank: false }
end
