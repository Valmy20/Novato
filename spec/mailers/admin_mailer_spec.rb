require 'rails_helper'

RSpec.describe AdminMailer, type: :mailer do
  before(:each) do
    @admin = create(:admin)
  end

  context 'when send email (token) to admin' do
    before(:each) do
      @mail = described_class.reset_password(@admin).deliver_now
    end

    it 'renders the subject' do
      expect(@mail.subject).to eq('Resetar senha: Novato Irecê')
    end

    it 'renders the receiver email' do
      expect(@mail.to).to eq([@admin.email])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(['from@example.com'])
    end
  end
end
