require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    User.destroy_all
    subject { described_class.new(ip_address: '127.0.0.1') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an ip_address' do
      subject.ip_address = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a duplicate ip_address' do
      subject.save
      duplicate_user = described_class.new(ip_address: '127.0.0.1')
      expect(duplicate_user).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has many searches' do
      user = User.reflect_on_association('searches')
      expect(user.macro).to eq(:has_many)
    end
  end
end
