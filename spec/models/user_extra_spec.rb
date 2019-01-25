require 'rails_helper'

RSpec.describe UserExtra, type: :model do
  subject(:model) { described_class.new }

  it 'has colums user extra' do
      user = described_class.column_names
      expect(user).to include('bio')
      expect(user).to include('user_id')
  end

  context 'when validation' do
    it 'validate bio lenght' do
      is_expected.to validate_length_of(:bio).
          is_at_least(10).
          is_at_most(500)
    end
  end

end
