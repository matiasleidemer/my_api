require 'rails_helper'

RSpec.describe 'User articles request', type: :request do
  let!(:user_article) { Article.create(title: 'Title', body: 'Body', user_id: user.id) }
  let!(:admin_article) { Article.create(title: 'Title', body: 'Body', user_id: admin.id) }

  let!(:user) do
    User.create(email: 'user@bar.com', password: '123change')
  end

  let!(:admin) do
    User.create(email: 'admin@bar.com', password: '123change', admin: true)
  end

  shared_examples 'unauthorized access' do
    it 'responds with unauthorized' do
      request
      expect(response.status).to eq(401)
    end
  end

  describe "get '/api/v1/articles'" do
    it 'reads all the articles' do
      get articles_path(user)
      expect(response).to render_template(:index)
    end
  end

  describe "get '/api/v1/article/:id" do
    it 'shows the article' do
      get article_path(user, id: user_article.id)
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
        expect(Article.count).to eql 2
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

  describe "patch '/api/v1/articles/:id'" do
    let(:request) { patch article_path(user, params) }

    context 'updating an authored article' do
      let(:params) do
        {
          id: user_article.id,
          article: { title: 'Foo Bar' }
        }
      end

      it 'updates the article' do
        request
        expect(user_article.reload.attributes)
          .to include(params[:article].with_indifferent_access)
      end

      it 'responds with ok status' do
        request
        expect(response.status).to eq(200)
      end
    end

    context 'updating an article from another user' do
      let(:params) do
        {
          id: admin_article.id,
          article: { title: 'Foo Bar' }
        }
      end

      it 'does not update the article' do
        request
        expect(admin_article.title).to eql 'Title'
      end

      include_examples 'unauthorized access'
    end
  end

  describe "delete '/api/v1/article/:id'" do
    let(:request) { delete article_path(user, params) }

    context 'deleting an authored article' do
      let(:params) { { id: user_article.id } }

      it 'destroys the article' do
        expect { request }.to change { Article.count }.by(-1)
      end

      it 'responds with no content status' do
        request
        expect(response.status).to eq(204)
      end
    end

    context 'deleting an article from another user' do
      let(:params) { { id: admin_article.id } }

      it 'does not destroy the article' do
        request
        expect(Article.count).to eql 2
      end

      include_examples 'unauthorized access'
    end
  end
end
