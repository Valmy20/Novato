require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:model) { described_class.new }

  it 'has colums category' do
      user = described_class.column_names
      expect(user).to include('name')
      expect(user).to include('slug')
      expect(user).to include('status')
      expect(user).to include('deleted')
      expect(user).to include('admin_id')
  end

  context 'when validation' do
    it 'validate name lenght' do
      is_expected.to validate_presence_of(:name)
    end
  end

end
