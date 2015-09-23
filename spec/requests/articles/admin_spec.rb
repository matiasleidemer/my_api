require 'rails_helper'

RSpec.describe 'Admin articles request', type: :request do
  let!(:user) do
    User.create(email: 'foo@bar.com', password: '123change', admin: true)
  end

  let!(:article) { Article.create(title: 'Title', body: 'Body', author: user) }

  describe "get '/api/v1/articles'" do
    it 'reads all the articles' do
      get articles_path(user)
      expect(response).to render_template(:index)
    end
  end

  describe "get '/api/v1/article/:id" do
    it 'shows the article' do
      get article_path(user, id: article.id)
      expect(response).to render_template(:show)
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
            published: Time.now.iso8601,
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

    context 'with invalid parameters' do
      let(:params) do
        {
          article: {
            title: ''
          }
        }
      end

      it 'does not creates a new article' do
        request
        expect(Article.count).to eql 1
      end

      it 'renders the error messages' do
        request
        expect(response.body).to match(/errors/)
      end

      it 'responds with unprocessable entity status' do
        request
        expect(response.status).to eq(422)
      end
    end
  end

  describe "patch '/api/v1/article/:id'" do
    let(:request) { patch article_path(user, params) }

    context 'with valid parameters' do
      let(:params) do
        {
          id: article.id,
          article: {
            title: 'Updated title',
            body: 'Updated body',
            user_id: user.id
          }
        }
      end

      it 'updates the article' do
        request
        expect(Article.last.attributes)
          .to include(params[:article].with_indifferent_access)
      end

      it 'renders the show template' do
        request
        expect(response).to render_template(:show)
      end

      it 'responds with ok status' do
        request
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid parameters' do
      let(:params) do
        {
          id: article.id,
          article: {
            title: ''
          }
        }
      end

      it 'does not update the article' do
        request
        expect(article.title).to eq('Title')
      end

      it 'renders the error messages' do
        request
        expect(response.body).to match(/errors/)
      end

      it 'responds with unprocessable entity status' do
        request
        expect(response.status).to eq(422)
      end
    end
  end

  describe "delete '/api/v1/article/:id'" do
    let(:request) { delete article_path(user, params) }

    context 'with valid parameters' do
      let(:params) { { id: article.id } }

      it 'destroys the article' do
        expect { request }.to change { Article.count }.by(-1)
      end

      it 'responds with no content status' do
        request
        expect(response.status).to eq(204)
      end
    end
  end
end
