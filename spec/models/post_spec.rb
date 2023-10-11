# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:chat) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
    it { expect(subject).to validate_length_of(:body).is_at_least(1) }
  end
end
