# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/highlighted.turbo_stream.erb', type: :feature do
  let!(:chat) { create(:chat) }
  let!(:post) { create(:post, chat:) }

  before { visit chat_path(chat.id) }

  it 'can highlight the post' do
    expect(page).to have_content('𓇼')
  end

  it 'toggles to highlighting/unhighlighting the post' do
    find_all('a').each do |a|
      next unless a[:href] == "/chats/#{chat.id}/posts/#{post.id}/highlight"

      click_link '𓇼'
      break
    end

    find_all('a').each do |a|
      next unless a[:href] == "/chats/#{chat.id}/posts/#{post.id}/highlight"

      click_link '⭐'
      break
    end
  end
end
