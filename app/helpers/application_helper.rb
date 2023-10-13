# frozen_string_literal: true

module ApplicationHelper
  def prepend_flash
    # tag 'flash' из соответствующего div для  флэша
    turbo_stream.prepend 'flash', partial: 'shared/flash'
  end
end
