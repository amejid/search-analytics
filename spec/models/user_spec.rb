require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    it 'returns error if email is empty' do
      user = User.new(password: '123456')
      expect(user.valid?).to eq false
    end

    it 'returns error if password is empty' do
      user = User.new(email: 'test@mail.com')
      expect(user.valid?).to eq false
    end

    it 'creates a user if both inputs are provided' do
      user = User.new(email: 'test@mail.com', password: '123456')
      expect(user.valid?).to eq true
    end
  end

  context 'Associations' do
    it 'has many searches' do
      user = User.reflect_on_association('searches')
      expect(user.macro).to eq(:has_many)
    end
  end
end
