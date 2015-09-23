require 'rails_helper'

RSpec.describe 'Guest articles request', type: :request do
  let!(:user) { User.new }
  let!(:article) { Article.create(title: 'Title', body: 'Body', author: admin) }

  let!(:admin) do
    User.create(email: 'foo@bar.com', password: '123change', admin: true)
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
      get article_path(user, id: article.id)
      expect(response).to render_template(:show)
    end
  end

  describe "post '/api/v1/articles'" do
    let(:request) { post articles_path(user, params) }

    let(:params) do
      {
        article: {
          title: 'Foo Bar',
          body: 'This is an article body',
          user_id: admin.id
        }
      }
    end

    it 'does not creates a new article' do
      request
      expect(Article.count).to eql 1
    end

    include_examples 'unauthorized access'
  end

  describe "patch '/api/v1/articles/:id'" do
    let(:request) { patch article_path(user, params) }

    let(:params) do
      {
        id: article.id,
        article: { title: 'Foo Bar' }
      }
    end

    it 'does not update the article' do
      request
      expect(article.title).to eql 'Title'
    end

    include_examples 'unauthorized access'
  end

  describe "delete '/api/v1/article/:id'" do
    let(:request) { delete article_path(user, id: article.id) }

    it 'does not destroy the article' do
      request
      expect(Article.count).to eql 1
    end

    include_examples 'unauthorized access'
  end
end
