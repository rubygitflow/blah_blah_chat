# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/new.html.erb', type: :feature do
  let!(:chat) { create(:chat) }

  before { visit chat_path(chat.id) }

  it 'creates a new post', js: true do
    click_link 'Add new post'
    within '#new_post' do
      find(:css, '#post_body').fill_in with: 'wqgtpPost'
      click_button 'Save'
    end
    within '#posts' do
      expect(page).to have_content('wqgtpPost')
    end
  end

  it 'cancels a new post', js: true do
    click_link 'Add new post'
    within '#new_post' do
      find(:css, '#post_body').fill_in with: 'Canceled Post'
      click_link 'Cancel'
    end
    within '#posts' do
      expect(page).not_to have_content('Canceled Post')
    end
    # puts page.html # check out how it works
  end
end
