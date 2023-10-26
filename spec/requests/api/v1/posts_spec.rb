# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :request do
  let(:headers) do
    {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end

  describe 'POST /api/v1/chats/:id/posts' do
    let!(:chat) { create(:chat) }
    let(:method) { :post }
    let(:api_path) { "/api/v1/chats/#{chat.id}/posts" }
    let(:wrong_api_path) { '/api/v1/chats/0/posts' }

    context 'with valid parameters' do
      let(:valid_params) { { 'body' => Faker::Lorem.sentence(word_count: 10) } }

      it 'saves a post in the database' do
        expect do
          do_request(method, api_path, valid_params.to_json, headers)
        end.to change(Post, :count).by(1)
      end

      it 'returns a post' do
        do_request(method, api_path, valid_params.to_json, headers)

        expect(response).to have_http_status(:created)
        expect(json['post']).to a_hash_including(valid_params)
      end

      context 'with wrong chat id in path' do
        it 'returns http unprocessable_entity' do
          do_request(method, wrong_api_path, valid_params.to_json, headers)

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with extra params "highlight"' do
        let(:new_valid_params) do
          {
            'post' => { 'body' => Faker::Lorem.sentence(word_count: 10) },
            'highlight' => true
          }
        end

        it 'saves a post in the database' do
          expect do
            do_request(method, api_path, new_valid_params.to_json, headers)
          end.to change(Highlight, :count).by(1)
        end
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { 'body' => ' ' * 10 }.to_json }

      it "does't create a new post" do
        expect do
          do_request(method, api_path, invalid_params, headers)
        end.to change(Post, :count).by(0)
      end

      it 'returns http unprocessable_entity' do
        do_request(method, wrong_api_path, invalid_params, headers)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error' do
        do_request(method, wrong_api_path, invalid_params, headers)

        expect(json['errors']).not_to be_empty
      end
    end
  end
end
