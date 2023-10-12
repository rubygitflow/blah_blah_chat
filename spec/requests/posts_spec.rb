# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:chat) { create(:chat) }

  # describe "GET /index" do
  #   let(:posts) do
  #     (1..3).map do |_ind|
  #       create(:post, chat: chat, body: Faker::Lorem.sentence(word_count: 5))
  #     end
  #   end

  #   before { get "/chats/#{chat.id}/posts" }

  #   it "returns http success" do
  #     expect(response).to have_http_status(:success)
  #   end

  #   it 'renders index view' do
  #     expect(response).to render_template(:index)
  #   end
  # end

  describe 'GET /new' do
    before { get "/chats/#{chat.id}/posts/new" }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new post view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      let(:valid_attributes) { { body: Faker::Lorem.sentence(word_count: 10), chat: } }

      it 'saves a post in the database' do
        expect do
          post chat_posts_url(chat.id), params: { post: valid_attributes }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to index' do
        post chat_posts_url(chat.id), params: { post: valid_attributes }
        expect(response).to redirect_to(chat_path(chat.id))
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { body: '', chat: } }

      it 'does not save the post' do
        expect do
          post chat_posts_url(chat.id), params: { post: invalid_attributes }
        end.not_to change(Post, :count)
      end

      it 're-renders a new view' do
        post chat_posts_url(chat.id), params: { post: invalid_attributes }
        expect(response).to render_template :new
      end

      it 'shows a reason of error' do
        post chat_posts_url(chat.id), params: { post: invalid_attributes }
        expect(response.body).to include('from being saved:')
      end

      it 'returns http unprocessable_entity' do
        post chat_posts_url(chat.id), params: { post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
