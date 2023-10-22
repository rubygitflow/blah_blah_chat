# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :topic }

    it do
      expect(subject).to validate_length_of(:topic).is_at_least(1).is_at_most(255)
    end
  end

  describe 'methods' do
    let!(:chat) { create(:chat) }

    describe 'before adding new posts' do
      before do
        chat.posts_count!
      end

      it 'posts_count!' do
        expect(chat.posts_count).to eq(0)
      end
    end

    describe 'after adding new posts' do
      let!(:posts) do
        (1..3).map { |_i| create(:post, chat_id: chat.id) }
      end

      before do
        chat.posts_count!
      end

      it 'posts_count!' do
        expect(chat.posts_count).to eq(3)
      end
    end
  end
end
