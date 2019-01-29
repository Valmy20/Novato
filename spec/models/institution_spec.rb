require 'rails_helper'

RSpec.describe Institution, type: :model do
  it 'has colums institution' do
    institution = described_class.column_names
    expect(institution).to include('name')
    expect(institution).to include('email')
    expect(institution).to include('password_digest')
    expect(institution).to include('token_reset')
    expect(institution).to include('logo')
    expect(institution).to include('cover')
    expect(institution).to include('slug')
    expect(institution).to include('status')
    expect(institution).to include('deleted')
  end

  # it do
  #   should accept_nested_attributes_for(:institution_extra)
  # end

  context 'when create institution' do
    it 'has secure token' do
      expect(Institution.create(
          name: 'IFBA',
          email: 'institution@ifba.edu.br',
          password: '123456',
          password_confirmation: '123456',
          status: 1
        ).token_reset).to be_present
    end
  end

  context 'validation presence' do
    it { is_expected.to validate_presence_of(:email) }
  end

  context 'when validation' do
    it 'allow_value email' do
      is_expected.to allow_value('institution@ifba.edu.br').for(:email)
    end

    it 'validate name lenght' do
      is_expected.to validate_length_of(:name).
          is_at_least(2).
          is_at_most(80)
    end

    it 'validate password lenght' do
      is_expected.to validate_length_of(:password).
          is_at_least(6).
          is_at_most(20)
    end
    it 'validate password_confirmation lenght' do
      is_expected.to validate_length_of(:password_confirmation).
          is_at_least(6).
          is_at_most(20)
    end
  end

end
