require 'rails_helper'

RSpec.describe Skill, type: :model do
  subject(:model) { described_class.new }

  it 'has colums skill' do
      user = described_class.column_names
      expect(user).to include('name')
      expect(user).to include('user_id')
  end

  context 'when validation' do
    it 'validate name lenght' do
      is_expected.to validate_length_of(:name).
          is_at_least(0).
          is_at_most(27)
    end
  end
end
