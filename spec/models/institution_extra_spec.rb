require 'rails_helper'

RSpec.describe InstitutionExtra, type: :model do
  subject(:model) { described_class.new }

  it 'has colums institution extras' do
      institution = described_class.column_names
      expect(institution).to include('about')
      expect(institution).to include('phone')
      expect(institution).to include('location')
      expect(institution).to include('institution_id')
  end

  context 'when validation' do
    it 'validate about lenght' do
      is_expected.to validate_length_of(:about).
          is_at_least(10).
          is_at_most(500)
    end
  end
end
