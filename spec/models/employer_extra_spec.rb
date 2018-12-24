require 'rails_helper'

RSpec.describe EmployerExtra, type: :model do
  subject(:model) { described_class.new }

  it 'has colums employer extras' do
      employer = described_class.column_names
      expect(employer).to include('about')
      expect(employer).to include('phone')
      expect(employer).to include('employer_id')
  end

  context 'when validation' do
    it 'validate bio lenght' do
      is_expected.to validate_length_of(:about).
          is_at_least(10).
          is_at_most(500)
    end
  end
end
