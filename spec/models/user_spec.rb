require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:model) { described_class.new }

  it 'has colums user' do
      user = described_class.column_names
      expect(user).to include('password_digest')
      expect(user).to include('avatar')
      expect(user).to include('cover')
      expect(user).to include('uid')
      expect(user).to include('status')
      expect(user).to include('provider')
      expect(user).to include('token_reset')
      expect(user).to include('credentials')
      expect(user).to include('slug')
      expect(user).to include('deleted')
  end

  context 'when create user' do
    it 'has secure token' do
      expect(User.create(
          # name: 'Valmy Ericles Nunes Machado',
          # email: 'user@localhost.com',
          password: '123456',
          password_confirmation: '123456',
          status: true
        ).token_reset).to be_present
    end
  end

  # context 'validation presence' do
  #   it { is_expected.to validate_presence_of(:email) }
  # end

  context 'when validation' do

    # it 'allow_value email' do
    #   is_expected.to allow_value('user@example.com').for(:email)
    # end

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
