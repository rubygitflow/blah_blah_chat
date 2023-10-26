# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:chat).touch(true).counter_cache(true) }
    it { is_expected.to have_one(:highlight).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
    it { expect(subject).to validate_length_of(:body).is_at_least(1) }
  end

  describe 'methods' do
    describe 'short_body' do
      let!(:chat) { create(:chat) }

      context "with a short post's body" do
        let!(:post) { create(:post, chat:, body: 'text') }

        it 'presents the full body in the short_body' do
          expect(post.short_body).to eq(post.body)
        end
      end

      context "with a long post's body" do
        let!(:post) { create(:post, chat:, body: Faker::Lorem.sentence(word_count: 20)) }

        it 'cuts the full body to the short_body' do
          expect(post.body.size).to be > 43
          expect(post.short_body.size).to eq(43)
        end
      end
    end
  end
end
