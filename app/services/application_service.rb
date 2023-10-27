# frozen_string_literal: true

class ApplicationService
  include AfterCommitEverywhere

  def self.call(...)
    new(...).call
  end

  def self.drop(...)
    new(...).drop
  end

  def initialize(*_); end

  def call
    return unless @object.present? && @object.respond_to?(:errors)

    # гарантируем обязательный возврат массива без ошибок
    [@object.errors.none?, @object]
  end

  def drop
    return unless @object.present?

    # гарантируем обязательный возврат статуса результата без ошибок
    @object&.destroyed?
  end

  private

  def commit_in_transaction
    return unless block_given?

    ActiveRecord::Base.transaction do
      result = yield

      # обращаемся к AfterCommitEverywhere
      after_commit { broadcast_call } if result && respond_to?(:broadcast_call, true)
    end
  end

  def broadcast_later(channel, template, **params)
    # https://rubydoc.info/github/hotwired/turbo-rails/Turbo/Broadcastable
    # or
    # https://www.hotrails.dev/turbo-rails/turbo-streams
    # _later сделает с помощью ActiveJob, если настроить sidekiq
    Turbo::StreamsChannel.broadcast_render_later_to(
      channel,
      template:,
      **params
    )
  end

  def broadcast_remove(channel, target)
    # https://www.hotrails.dev/turbo-rails/turbo-streams
    # _later would be impossible
    Turbo::StreamsChannel.broadcast_remove_to(
      channel,
      target:
    )
  end
end
