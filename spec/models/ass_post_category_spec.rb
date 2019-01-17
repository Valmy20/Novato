require 'rails_helper'

RSpec.describe AssPostCategory, type: :model do
  it 'has colums AssPostCategory' do
    association = described_class.column_names
    expect(association).to include('post_id')
    expect(association).to include('category_id')
  end
end
