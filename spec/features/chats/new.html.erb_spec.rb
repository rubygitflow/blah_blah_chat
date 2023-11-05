# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/new.html.erb', type: :feature do
  it 'creates a new chat' do
    visit chats_path
    click_link 'Add new chat'
    find(:css, '#chat_topic').fill_in with: 'wqgtpChat'
    click_button 'Save'
    within '#showChat' do
      expect(page).to have_content('wqgtpChat')
    end
    # puts page.html # check out how it works
  end
end
