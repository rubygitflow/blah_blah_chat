# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chats/edit.html.erb', type: :feature do
  let!(:chat) { create(:chat) }
  let!(:old_topic) { chat.topic }

  before { visit chats_path }

  it 'can edit the chat topic' do
    page.has_title? 'Change the chat name'
  end

  it 'edits the chat topic', js: true do
    expect(page).to have_content(old_topic)
    expect(page).to have_css('.bi-pencil')

    page.find("a[href=\"/chats/#{chat.id}/edit\"]").click
    page.find(:css, '#chat_topic').fill_in with: '123fds'
    # sleep 1
    # save_and_open_page
    click_button 'Save'
    # puts "page after Cancel click #{page.html}" # check out how it works
    sleep 1
    visit chats_path
    sleep 1
    # puts "page after revisit page #{page.html}" # check out how it works
    d = page.find(:css, "#chat_#{chat.id}").text
    # puts "d = #{d.inspect}"
    # save_and_open_page
    expect(d).to have_content('123fds')
    expect(d).not_to have_content(old_topic)
  end

  it 'cancels to edit the chat topic', js: true do
    expect(page).to have_content(old_topic)

    page.find("a[href=\"/chats/#{chat.id}/edit\"]").click
    # save_and_open_page
    find(:css, '#chat_topic').fill_in with: '123fds'
    # sleep 1
    click_link 'Cancel'
    # puts "page after Cancel click #{page.html}" # check out how it works
    sleep 1
    visit chats_path
    # puts "page after revisit page #{page.html}" # check out how it works
    sleep 1
    d = find(:css, "#chat_#{chat.id}").text
    # puts "d = #{d.inspect}"
    expect(d).not_to have_content('123fds')
    expect(d).to have_content(old_topic)
  end
end
