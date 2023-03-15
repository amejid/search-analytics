require 'rails_helper'

RSpec.describe Search, type: :model do
  before(:example) do
    @user = User.create(email: 'test@mail.com', password: '123456')
  end

  context 'Validations' do
    it 'returns error if query is less than 3 characters' do
      search = Search.new(query: 'Hw', user_id: @user.id)
      expect(search.valid?).to eq false
    end

    it 'returns error if query is more than 50 characters' do
      search = Search.new(query: 'ab' * 27, user_id: @user.id)
      expect(search.valid?).to eq false
    end

    it 'returns error if user is not specified' do
      search = Search.new(query: 'Hwewewaeas')
      expect(search.valid?).to eq false
    end

    it 'returns success if title is more than 3 characters' do
      search = Search.new(query: 'Hwewewaeas', user_id: @user.id)
      expect(search.valid?).to eq true
    end
  end
end
