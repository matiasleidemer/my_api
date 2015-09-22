require 'rails_helper'

RSpec.describe 'Admin articles request', type: :request do
  let(:user) do
    User.create(email: 'foo@bar.com', password: '123change', admin: true)
  end

  describe "get '/api/v1/articles'" do
    it 'reads all the articles' do
      get articles_path(user)
      expect(response).to render_template(:index)
    end
  end

  describe "post '/api/v1/articles'" do
    let(:request) { post articles_path(user, params) }

    context 'with valid parameters' do
      let(:params) do
        {
          article: {
            title: 'Foo Bar',
            body: 'This is an article body',
            user_id: user.id
          }
        }
      end

      it 'creates a new article' do
        expect { request }.to change { Article.count }.by(1)
      end

      it 'renders the show template' do
        request
        expect(response).to render_template(:show)
      end

      it 'responds with created status' do
        request
        expect(response.status).to eq(201)
      end
    end
  end
end
