require 'rails_helper'

RSpec.describe 'Articles controller', type: :request do
  before(:example) do
    user = User.create(email: 'test@mail.com', password: '123456')
    sign_in user

    (1..100).each do |a|
      Article.create(
        title: "Item #{a}"
      )
    end
  end

  it 'renders 50 articles' do
    get root_path

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:index)

    expect(response.body).to include('Item 2')
  end

  it 'does not render more than 50 articles' do
    get root_path

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:index)

    expect(response.body).not_to include('Item 87')
  end
end
