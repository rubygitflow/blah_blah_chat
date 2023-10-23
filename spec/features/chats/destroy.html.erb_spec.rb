# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/destroy.html.erb', type: :feature do
  let!(:chat) { create(:chat) }

  before { visit chats_path }

  it 'can destroy the chat' do
    page.has_title? 'Destroy chat'
  end

  it 'destroys the chat' do
    expect(page).to have_content(chat.topic)

    find_all('a').each do |a|
      next unless a[:href] == "/chats/#{chat.id}" && a[:'data-turbo-method'] == 'delete'

      a.click
      expect(page).not_to have_content(chat.topic)
      break
    end
  end
end
