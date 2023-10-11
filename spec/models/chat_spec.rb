# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :topic }
    it do 
      is_expected.to validate_length_of(:topic).is_at_least(1).is_at_most(255)
    end
  end
end
