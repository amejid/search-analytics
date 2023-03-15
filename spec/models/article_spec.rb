require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'Validations' do
    it 'returns error if title is less than 3 characters' do
      article = Article.new(title: 'Hw')
      expect(article.valid?).to eq false
    end

    it 'returns error if title is more than 50 characters' do
      article = Article.new(title: 'ab' * 27)
      expect(article.valid?).to eq false
    end

    it 'returns success if title is more than 3 characters' do
      article = Article.new(title: 'Hwewewaeas')
      expect(article.valid?).to eq true
    end
  end
end
