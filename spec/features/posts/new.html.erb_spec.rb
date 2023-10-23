# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/new.html.erb', type: :feature do
  let!(:chat) { create(:chat) }

  before { visit chat_path(chat.id) }

  it 'creates a new post' do
    click_link 'Add new post'
    find(:css, '#post_body').fill_in with: 'wqgtpPost'
    click_button 'Save'
    expect(page).to have_content('wqgtpPost')
  end
end
