require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    subject { described_class.new(query: 'Sample Query', user: User.new(ip_address: '127.0.0.1')) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a query' do
      subject.query = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a query shorter than 3 characters' do
      subject.query = 'a' * 2
      expect(subject).to_not be_valid
    end

    it 'is not valid with a query longer than 50 characters' do
      subject.query = 'a' * 51
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      search = Search.reflect_on_association('user')
      expect(search.macro).to eq(:belongs_to)
    end
  end
end
