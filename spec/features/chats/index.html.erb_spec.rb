# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/index.html.erb', type: :feature do
  let!(:extra_chats_count) { 20 }
  let!(:extra_chats) { create_list(:chat, extra_chats_count) }
  let!(:chats) { create_list(:chat, 3) }

  before { visit chats_path }

  it 'shows a topic list of chats' do
    chats.each do |elem|
      expect(page).to have_content(elem.topic)
    end
  end

  it "shows an app's caption" do
    expect(page).to have_content('Blah_blah_chat')
  end

  it 'shows a new Chat button' do
    expect(find(:css, '.btn-danger')).to have_content('Add new chat')
  end

  it 'shows zero posts count' do
    chats.each do |elem|
      expect(find(:css, "#chat_#{elem.id}_posts_count")).to have_content('(0)')
    end
  end

  context 'with adding posts' do
    let!(:posts) do
      (1..3).map { |_e| create(:post, chat: chats[0]) }
    end

    it 'shows real number of posts' do
      visit chats_path
      expect(find(:css, "#chat_#{chats[0].id}_posts_count")).to have_content('(3)')
    end
  end

  describe 'infinite scrolling' do
    context 'when opening the chat index' do
      it 'retrieves part of the list of chats' do
        expect(page).to have_css("#chat_#{extra_chats[-1].id}")
        expect(page).not_to have_css("#chat_#{extra_chats[0].id}")
      end
    end

    context 'when scrolling the chat index', js: true do
      it 'autoloads the entire list of chats' do
        expect(page).to have_css("#chat_#{extra_chats[-1].id}")
        page.execute_script 'window.scrollTo(0,10000)'
        expect(page).to have_css("#chat_#{extra_chats[0].id}")
      end
    end
  end
end
