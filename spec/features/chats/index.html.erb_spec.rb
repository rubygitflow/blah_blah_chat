# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/index.html.erb', type: :feature do
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
    # let!(:posts) do
    #   [1..3].map { create(:post, chat: chats[0]) }
    # end
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
