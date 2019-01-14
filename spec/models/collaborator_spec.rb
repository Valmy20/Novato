require 'rails_helper'

RSpec.describe Collaborator, type: :model do

    it 'has colums collaborator' do
        collaborator = described_class.column_names
        expect(collaborator).to include('name')
        expect(collaborator).to include('email')
        expect(collaborator).to include('password_digest')
        expect(collaborator).to include('avatar')
        expect(collaborator).to include('token_reset')
        expect(collaborator).to include('deleted')
    end

    context 'when create collaborator' do
      it 'has secure token' do
        expect(Collaborator.create(
            name: 'Valmy Ericles Nunes Machado',
            email: 'collaborator@localhost.com',
            password: '123456',
            password_confirmation: '123456',
            status: :disapproved
          ).token_reset).to be_present
      end
    end

    context 'validation presence' do
      it { is_expected.to validate_presence_of(:email) }
    end

    context 'when validation' do

      it 'allow_value email' do
        is_expected.to allow_value('valmyericles@gmail.com').for(:email)
      end

      it 'validate name lenght' do
        is_expected.to validate_length_of(:name).
            is_at_least(2).
            is_at_most(50)
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
