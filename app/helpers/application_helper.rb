# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def replace_flash
    # tag 'flash' из соответствующего div для флэша
    turbo_stream.replace 'flash', partial: 'shared/flash'
  end
end
