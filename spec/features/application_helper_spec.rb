# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationHelper', type: :feature do
  describe 'replace_flash: Page can show the flash message' do
    it 'creating a chat' do
      visit root_path
      click_link 'Add new chat'
      find(:css, '#chat_topic').fill_in with: 'Chat'
      click_button 'Save'
      success_message = 'The Chat successfully created.'
      expect(page).to have_content(success_message)
    end
  end
end
