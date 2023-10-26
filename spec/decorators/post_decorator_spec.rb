# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostDecorator, type: :decorator do
  let(:post) { FactoryBot.build_stubbed(:post).decorate }

  it 'returns the displayed days' do
    expect(post.highlight).to eq('𓇼')
  end
end
