require 'rails_helper'

RSpec.describe 'Searches controller', type: :request do
  before(:example) do
    user = User.create(email: 'test@mail.com', password: '123456')
    sign_in user

    (1..30).each do |a|
      Search.create(
        query: "Item #{a}",
        user_id: user.id
      )
    end
  end

  it 'renders top 20 searches' do
    get searches_path

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:index)

    expect(response.body).to include('Item 2')
  end
end
