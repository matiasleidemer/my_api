require 'rails_helper'

RSpec.describe 'User comments request', type: :request do
  let!(:article) { Article.create(title: 'Title', body: 'Body', author: user) }
  let!(:comment) { Comment.create(author: 'User', body: 'Body', article: article) }

  let!(:user) do
    User.create(email: 'foo@bar.com', password: '123change')
  end

  describe "get '/api/v1/articles/:article_id/comments'" do
    it 'reads all comments from article' do
      get comments_path(user, article)
      expect(response).to render_template(:index)
    end
  end

  describe "get '/api/v1/articles/:article_id/comment" do
    it 'shows the comment from article' do
      get comment_path(user, article, id: comment.id)
      expect(response).to render_template(:show)
    end
  end

  describe "post '/api/v1/articles/:article_id/comments'" do
    let(:request) { post comments_path(user, article, params) }

    context 'with valid parameters' do
      let(:params) do
        {
          comment: {
            author: 'Great User',
            body: 'This is an comment body'
          }
        }
      end

      it 'creates a new comment for the article' do
        expect { request }.to change { article.comments.count }.by(1)
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
          comment: {
            body: ''
          }
        }
      end

      it 'does not creates a new comment' do
        request
        expect(article.comments.count).to eql 1
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

  describe "patch '/api/v1/articles/:article_id/comment/:id'" do
    let(:request) { patch comment_path(user, article, params) }
    let(:params) do
      {
        id: comment.id,
        comment: {
          body: 'Updated body'
        }
      }
    end

    it 'responds with unauthorized' do
      request
      expect(response.status).to eq(401)
    end
  end

  describe "delete '/api/v1/article/:article_id/comment/:id'" do
    let(:request) { delete comment_path(user, article, params) }
    let(:params) { { id: comment.id } }

    it 'responds with unauthorized' do
      request
      expect(response.status).to eq(401)
    end
  end
end
