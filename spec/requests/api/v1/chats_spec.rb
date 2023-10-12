# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ChatsController, type: :request do
  let(:headers) do
    {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end

  describe 'GET /api/v1/chats' do
    let!(:chats) { create_list(:chat, 3) }
    let!(:chat) { chats.last }  # we'll looking for the first elenm from inverted list
    let(:method) { :get }
    let(:api_path) { '/api/v1/chats' }

    before do
      do_request(method, api_path, nil, headers)
    end

    it 'returns list of chats' do
      expect(json['chats'].size).to eq(3)
    end

    it 'contains all public fields' do
      %w[id topic created_at updated_at].each do |attr|
        expect(json['chats'].first[attr]).to eq(chat.send(attr).as_json)
      end
    end
  end
end
