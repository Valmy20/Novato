require 'rails_helper'

RSpec.describe Compete, type: :model do
  it 'has colums compete' do
      compete = described_class.column_names
      expect(compete).to include('user_id')
      expect(compete).to include('publication_id')
  end
end
