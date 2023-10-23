# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/destroy.html.erb', type: :feature do
  let!(:chat) { create(:chat) }
  let!(:old_topic) { chat.topic }

  before { visit chats_path }

  it 'can edit the chat topic' do
    page.has_title? 'Change the chat name'
  end

  it 'edits the chat topic' do
    expect(page).to have_content(old_topic)

    find_all('a').each do |a|
      next unless a[:href] == "/chats/#{chat.id}/edit"

      a.click
      find(:css, '#chat_topic').fill_in with: '123fds'
      click_button 'Save'
      expect(page).to have_content('123fds')
      expect(page).not_to have_content(old_topic)
      break
    end
  end
end
