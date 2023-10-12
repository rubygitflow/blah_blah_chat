# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    topic { Faker::Lorem.sentence(word_count: 5) }
  end
end
