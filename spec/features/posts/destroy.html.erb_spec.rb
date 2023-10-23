# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/destroy.html.erb', type: :feature do
  let!(:chat) { create(:chat) }
  let!(:post) { create(:post, chat:) }

  before { visit chat_path(chat.id) }

  it 'can destroy the post' do
    page.has_title? 'Destroy post'
  end

  it 'destroys the post' do
    expect(page).to have_content(post.body)

    find_all('a').each do |a|
      next unless a[:href] == "/chats/#{chat.id}/posts/#{post.id}"

      a.click
      expect(page).not_to have_content(post.body)
      break
    end
  end
end
