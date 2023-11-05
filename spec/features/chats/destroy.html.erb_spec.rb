# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/destroy.html.erb', type: :feature do
  let!(:chat) { create(:chat) }

  before { visit chats_path }

  it 'can destroy the chat' do
    page.has_title? 'Destroy chat'
  end

  it 'destroys the chat', js: true do
    expect(page).to have_content(chat.topic)
    expect(page).to have_css('.bi-trash')

    within "#chat_#{chat.id}" do
      accept_confirm do
        page.find('.bi-trash').click
      end
    end
    # puts page.html # check out how it works

    within '#chats' do
      expect(page).not_to have_content(chat.topic)
    end
  end
end
