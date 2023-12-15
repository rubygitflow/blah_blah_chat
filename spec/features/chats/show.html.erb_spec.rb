# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/show.html.erb', type: :feature do
  let!(:chat) { create(:chat) }
  let!(:posts) do
    (1..30).map { |_i| create(:post, chat_id: chat.id) }
  end

  describe 'key elements of the posts page' do
    before { visit chat_path(chat.id) }

    it 'shows a chat with post' do
      expect(page).to have_content(chat.topic)
      expect(page).to have_content(posts[-1].body)
    end

    it 'shows a new Post button' do
      expect(find(:css, '.btn-primary')).to have_content('Add new post')
    end
  end

  describe 'infinite scrolling', js: true do
    before do
      visit chat_path(chat.id)
    end

    context 'when opening the chat page' do
      it 'retrieves part of the list of posts' do
        expect(page).to have_css("#post_#{posts[-1].id}")
        expect(page).not_to have_css("#post_#{posts[0].id}")
      end
    end

    context 'when scrolling the chat page' do
      it 'autoloads the entire list of posts' do
        expect(page).to have_css("#post_#{posts[-1].id}")
        page.execute_script 'window.scrollBy(0,document.documentElement.scrollHeight)'
        sleep 0.5
        page.execute_script 'window.scrollTo(0,document.documentElement.scrollHeight)'
        sleep 0.5
        expect(page).to have_css("#post_#{posts[0].id}")
      end
    end
  end
end
