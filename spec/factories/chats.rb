# frozen_string_literal: true

FactoryBot.define do
  factory(:chat) do
    topic { Faker::Lorem.words(number: 5) }
  end
end
