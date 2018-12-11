require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject(:model) { described_class.new }

  it 'has colums admin' do
      user = described_class.column_names
      expect(user).to include('name')
      expect(user).to include('email')
      expect(user).to include('password_digest')
      expect(user).to include('token_reset')
      expect(user).to include('status')
      expect(user).to include('deleted')
  end

  context 'when create admin' do
    it 'has secure token' do
      expect(Admin.create(
          name: 'Valmy Ericles Nunes Machado',
          email: 'admin@localhost.com',
          password: '123456',
          password_confirmation: '123456',
          status: true
        ).token_reset).to be_present
    end
  end

  context 'validation presence' do
    it { is_expected.to validate_presence_of(:email) }
  end

  context 'when validation' do

    it 'allow_value email' do
      is_expected.to allow_value('user@example.com').for(:email)
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
