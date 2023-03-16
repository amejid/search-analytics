require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  describe 'GET /searches' do
    before do
      @user = User.create(ip_address: '127.0.0.1')
      30.times { |i| Search.create(query: "search #{i}", user: @user) }
    end

    it 'renders the index template' do
      get searches_path
      expect(response).to render_template(:index)
    end

    it 'assigns the correct searches to @searches' do
      get searches_path
      expect(assigns(:searches).size).to eq(20)
      expect(assigns(:searches).first.query).to eq('search 20')
    end

    it 'returns a successful response' do
      get searches_path
      expect(response).to have_http_status(:success)
    end
  end
end
