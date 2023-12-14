# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/highlighted.turbo_stream.erb', type: :feature do
  let!(:chat) { create(:chat) }
  let!(:post) { create(:post, chat:) }

  before { visit chat_path(chat.id) }

  it 'can highlight the post' do
    expect(page).to have_content('𓇼')
  end

  it 'toggles to highlighting/unhighlighting the post', js: true do
    expect(page).not_to have_content('⭐')
    click_on '𓇼'
    expect(page).not_to have_content('𓇼')
    click_on '⭐'
    expect(page).not_to have_content('⭐')
  end
end
