require 'rails_helper'

RSpec.describe EmailDomain, type: :model do
  describe '#valid?' do
    context 'presence'
    it 'false when email domain is empty' do
      email_domain = EmailDomain.new(domain: '')
      expect(email_domain).not_to be_valid
    end

    it 'should create a new email domain' do
      email_domain = EmailDomain.new(domain: 'domain@domain.com')
      expect(email_domain).to be_valid
    end

  end
end
