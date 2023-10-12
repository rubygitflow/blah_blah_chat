# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  describe 'GET /index' do
    let(:chats) { create_list(:chat, 3) }

    before { get '/chats' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    let(:chat) { create(:chat) }

    before { get "/chats/#{chat.id}" }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'populates a chat' do
      expect(response.body).to include("Chat: #{chat.topic}")
    end

    it 'renders show view' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /new' do
    before { get '/chats/new' }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new chat view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      let(:valid_attributes) { { topic: Faker::Lorem.sentence(word_count: 5) } }

      it 'saves a chat topic in the database' do
        expect do
          post chats_url, params: { chat: valid_attributes }
        end.to change(Chat, :count).by(1)
      end

      it 'redirects to show' do
        post chats_url, params: { chat: valid_attributes }
        expect(response).to redirect_to(assigns(:chat))
      end

      it 'redirects to the last Chat page' do
        post chats_url, params: { chat: valid_attributes }
        expect(response).to redirect_to(chat_url(Chat.last))
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { topic: '' } }

      it 'does not save the chat' do
        expect do
          post chats_url, params: { chat: invalid_attributes }
        end.not_to change(Chat, :count)
      end

      it 're-renders a new view' do
        post chats_url, params: { chat: invalid_attributes }
        expect(response).to render_template :new
      end

      it 'shows a reason of error' do
        post chats_url, params: { chat: invalid_attributes }
        expect(response.body).to include('from being saved:')
      end

      it 'returns http unprocessable_entity' do
        post chats_url, params: { chat: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
