# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/new.html.erb', type: :feature do
  before { visit chats_path }

  it 'creates a new chat', js: true do
    click_link 'Add new topic'
    find(:css, '#chat_topic').fill_in with: 'wqgtpChat'
    click_button 'Save'
    within '#chats' do
      expect(page).to have_content('wqgtpChat')
    end
    # puts page.html # check out how it works
  end

  it 'cancels a new chat', js: true do
    click_link 'Add new topic'
    within '#modal_content' do
      find(:css, '#chat_topic').fill_in with: 'Canceled Chat'
      expect(page).to have_css('.btn-close')
      # save_and_open_page
      sleep 1
      find(:css, '.btn-close').click
    end
    sleep 1
    expect(page).to have_no_selector('#modal_content')
    within '#chats' do
      expect(page).not_to have_content('Canceled Chat')
    end
    # puts page.html # check out how it works
  end

  it 'cancels a new chat with the Escape pressed', js: true do
    click_link 'Add new topic'

    within '#modal_content' do
      el = find(:css, '#chat_topic')
      el.fill_in with: 'Canceled Chat'
      sleep 1
      el.send_keys(:escape)
    end
    sleep 1
    expect(page).to have_no_selector('#modal_content')

    within '#chats' do
      expect(page).not_to have_content('Canceled Chat')
    end
    # puts page.html # check out how it works
  end
end
