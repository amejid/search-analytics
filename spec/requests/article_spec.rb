require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe 'GET #index' do
    let!(:article1) { Article.create(title: 'Test Article 1') }
    let!(:article2) { Article.create(title: 'Test Article 2') }
    let!(:article3) { Article.create(title: 'Test Article 3') }
    let!(:article4) { Article.create(title: 'Test Article 4') }

    before(:example) do
      @current_user = User.create(ip_address: '127.0.0.1')
    end

    context 'when a query is present' do
      let(:query) { 'Test Article 1' }

      before do
        get articles_path, params: { query: }
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns articles matching the query' do
        expect(response.body).to include(article1.title)
      end

      it 'does not return articles not matching the query' do
        expect(response.body).not_to include(article2.title)
        expect(response.body).not_to include(article3.title)
        expect(response.body).not_to include(article4.title)
      end
    end

    context 'when a query is not present' do
      before do
        get articles_path
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns all articles' do
        expect(response.body).to include(article1.title)
        expect(response.body).to include(article2.title)
        expect(response.body).to include(article3.title)
        expect(response.body).to include(article4.title)
      end

      it 'does not save a search query' do
        expect(@current_user.searches).to be_empty
      end
    end
  end
end
