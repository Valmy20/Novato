require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has colums message extras' do
      message = described_class.column_names
      expect(message).to include('email')
      expect(message).to include('body')
      expect(message).to include('deleted')
  end

  context 'when validation' do
    it 'validate body lenght' do
      is_expected.to validate_length_of(:body).
          is_at_least(2).
          is_at_most(500)
    end
  end
end
