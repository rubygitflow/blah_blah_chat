# frozen_string_literal: true

class PostDecorator < Draper::Decorator
  delegate_all

  def highlight
    if object.highlight.present?
      '⭐'
    else
      '𓇼'
    end
  end
end
