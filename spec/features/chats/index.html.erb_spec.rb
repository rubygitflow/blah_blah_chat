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
end
