# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let!(:chat) { create(:chat) }

  describe 'GET http /new' do
    before { get "/chats/#{chat.id}/posts/new" }

    it 'renders a successful Redirection response' do
      expect(response).to have_http_status(:found)
    end

    it 'redirects to chats view' do
      expect(response).to redirect_to('/')
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

      it 'displays a flash notification' do
        post chat_posts_url(chat.id), params: { post: valid_attributes }

        expect(response.body).to include('Your post successfully created.')
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

  describe 'DELETE /destroy' do
    let!(:post) { create(:post, chat:) }

    it 'destroys the requested post' do
      expect do
        delete chat_post_url(chat.id, post.id)
      end.to change(Post, :count).by(-1)
    end

    it 'renders flash view' do
      delete chat_post_url(chat.id, post.id)

      expect(response.body).to include('deleted!')
    end

    context 'with the wrong path' do
      it 'returns http unprocessable_entity' do
        delete chat_post_url(post.id, chat.id)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
