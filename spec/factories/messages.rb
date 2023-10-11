# frozen_string_literal: true

FactoryBot.define do
  factory(:message) do
    body { Faker::Lorem.sentence(word_count: 10) }
    chat
  end
end
