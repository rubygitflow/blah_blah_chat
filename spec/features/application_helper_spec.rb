# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationHelper', type: :feature do
  describe 'replace_flash: Page can show the flash message' do
    it 'creating a chat', js: true do
      # visit root_path
      visit chats_path
      click_link 'Add new topic'
      within '#remote_modal_body' do
        find(:css, '#chat_topic').fill_in with: 'Chat-=|'
        sleep 0.5
        click_button 'Save'
      end
      within '#chats' do
        expect(page).to have_content('Chat-=|')
      end
      success_message = 'The Chat successfully created.'
      expect(page).to have_content(success_message)
    end
  end
end
