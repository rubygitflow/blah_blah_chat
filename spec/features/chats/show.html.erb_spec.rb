# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/show.html.erb', type: :feature do
  let!(:chat) { create(:chat) }
  let!(:post) { create(:post, chat:) }

  before { visit chat_path(chat.id) }

  it 'shows a chat with post' do
    expect(page).to have_content(chat.topic)
    expect(page).to have_content(post.body)
  end

  it 'shows a new Post button' do
    expect(find(:css, '.btn-primary')).to have_content('Add new post')
  end
end
