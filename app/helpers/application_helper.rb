# frozen_string_literal: true

module ApplicationHelper
  def replace_flash
    # tag 'flash' из соответствующего div для  флэша
    turbo_stream.replace 'flash', partial: 'shared/flash'
  end
end
