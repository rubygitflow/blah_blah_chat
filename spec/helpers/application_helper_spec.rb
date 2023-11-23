# frozen_string_literal: true

require 'rails_helper'

describe ApplicationHelper do
  describe 'html_line_wrapping: formatting text content' do
    let(:text_break_tag) { '<div class="text-break col">' }

    it 'replaces line breaks with the <br> tag' do
      input = "string 1\ntring 2"
      expect(helper.html_line_wrapping(input, :br)).to include(text_break_tag)
      expect(helper.html_line_wrapping(input, :br)).to include('<br>')
    end

    it 'can move long words to the next line in html with :pre style' do
      input = 'long_string' * 10
      expect(helper.html_line_wrapping(input, :pre)).to include(text_break_tag)
      expect(helper.html_line_wrapping(input, :pre)).to include('<pre style="white-space: pre-wrap;">')
      expect(helper.html_line_wrapping(input, :pre)).to include(input)
    end

    it 'can move long words to the next line in html with :p style' do
      input = "string 1\ntring 2"
      expect(helper.html_line_wrapping(input, :p)).to include(text_break_tag)
      expect(helper.html_line_wrapping(input, :p)).to include('<p>string 1</p><p>tring 2</p>')
    end

    it 'returns the string as is for the wrong style index but includes .text-break css class' do
      input = 'long_string' * 10
      expect(helper.html_line_wrapping(input, :any_wrong_style)).to include(text_break_tag)
      expect(helper.html_line_wrapping(input, :any_wrong_style)).to include(input)
    end
  end
end
