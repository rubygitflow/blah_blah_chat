# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/index.html.erb', type: :feature do
  let!(:extra_chats_count) { 30 }
  let!(:extra_chats) { create_list(:chat, extra_chats_count) }
  let!(:chats) { create_list(:chat, 3) }

  describe 'key elements of the chats page' do
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
      expect(find(:css, '.btn-danger')).to have_content('Add new topic')
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
  end

  describe 'infinite scrolling', js: true do
    # we prevent the exclusion of data by the time of the creation of chats
    before do
      sleep 1
      visit chats_path
    end

    context 'when opening the chat index' do
      it 'retrieves part of the list of chats' do
        expect(page).to have_css("#chat_#{extra_chats[-1].id}")
        expect(page).not_to have_css("#chat_#{extra_chats[0].id}")
      end
    end

    context 'when scrolling the chat index' do
      it 'autoloads the entire list of chats' do
        expect(page).to have_css("#chat_#{extra_chats[-1].id}")
        page.execute_script 'window.scrollTo(0,document.documentElement.scrollHeight)'
        sleep 0.5
        page.execute_script 'window.scrollTo(0,document.documentElement.scrollHeight)'
        sleep 0.5
        page.execute_script 'window.scrollTo(0,document.documentElement.scrollHeight)'
        sleep 0.5
        # save_and_open_page
        # the next expectation is interrupted periodically. No idea :(
        expect(page).to have_css("#chat_#{extra_chats[0].id}")
      end
    end
  end
end
