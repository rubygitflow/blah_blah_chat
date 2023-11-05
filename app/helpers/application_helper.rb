# frozen_string_literal: true

module ApplicationHelper
  def replace_flash
    # tag 'flash' из соответствующего div для флэша
    turbo_stream.replace 'flash', partial: 'shared/flash'
  end

  def html_line_wrapping(text, style = :br)
    text = h(text)
    text = case style
           when :br
             text.gsub("\n", '<br>')
           when :pre
             "<pre style=\"white-space: pre-wrap;\">#{text}</pre>"
           when :p
             text.split("\n").inject('') { |res, el| res + "<p>#{el}</p>" }
           else
             text
           end
    "<div class=\"text-break\">#{text}</div>".html_safe
  end
end
