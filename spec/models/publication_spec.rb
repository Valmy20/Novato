require 'rails_helper'

RSpec.describe Publication, type: :model do

  it 'has colums publication' do
    publication = described_class.column_names
    expect(publication).to include('title')
    expect(publication).to include('_type')
    expect(publication).to include('slug')
    expect(publication).to include('information')
    expect(publication).to include('remunaration')
    expect(publication).to include('vacancies')
    expect(publication).to include('location')
    expect(publication).to include('publicationable_type')
    expect(publication).to include('publicationable_id')
  end

  context 'validation presence' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:vacancies) }
  end

   context 'when validation' do
     it 'validate title lenght' do
       is_expected.to validate_length_of(:title).
        is_at_least(4).
        is_at_most(100)
     end
     it 'validate information lenght' do
       is_expected.to validate_length_of(:information).
        is_at_least(10).
        is_at_most(700)
     end
   end
end
