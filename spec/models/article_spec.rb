require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    subject { described_class.new(title: 'Sample Title') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a title shorter than 3 characters' do
      subject.title = 'a' * 2
      expect(subject).to_not be_valid
    end

    it 'is not valid with a title longer than 50 characters' do
      subject.title = 'a' * 51
      expect(subject).to_not be_valid
    end
  end
end
