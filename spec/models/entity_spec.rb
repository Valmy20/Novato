require 'rails_helper'

RSpec.describe Entity, type: :model do
  subject(:model) { described_class.new }

  it 'has colums entity' do
      user = described_class.column_names
      expect(user).to include('name')
      expect(user).to include('email')
  end

  context 'validation presence' do
    it { is_expected.to validate_presence_of(:email) }
  end

  context 'when validation' do

    it 'allow_value email' do
      is_expected.to allow_value('user@example.com').for(:email)
    end

    it 'validate name lenght' do
      is_expected.to validate_length_of(:name).
          is_at_least(2).
          is_at_most(30)
    end
  end
end
