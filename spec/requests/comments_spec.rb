require 'rails_helper'

RSpec.describe 'Admin comments request', type: :request do
  let!(:article) { Article.create(title: 'Title', body: 'Body', author: user) }
  let!(:comment) { Comment.create(author: 'User', body: 'Body', article: article) }
  let!(:user) { create(:admin) }

  before { authenticate_request_for(user) }

  describe "get '/api/v1/articles/:article_id/comments'" do
    it 'reads all comments from article' do
      get api_v1_article_comments_path(article), {}, @env
      expect(response).to render_template(:index)
    end
  end

  describe "get '/api/v1/articles/:article_id/comment" do
    it 'shows the comment from article' do
      get api_v1_article_comment_path(article, comment), {}, @env
      expect(response).to render_template(:show)
    end
  end

  describe "post '/api/v1/articles/:article_id/comments'" do
    let(:request) { post api_v1_article_comments_path(article, params), {}, @env }

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
    let(:request) { patch api_v1_article_comment_path(article, params), {}, @env }

    context 'with valid parameters' do
      let(:params) do
        {
          id: comment.id,
          comment: {
            body: 'Updated body'
          }
        }
      end

      it 'updates the comment' do
        request
        expect(article.comments.last.attributes)
          .to include(params[:comment].with_indifferent_access)
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
          id: comment.id,
          comment: {
            body: ''
          }
        }
      end

      it 'does not update the comment' do
        request
        expect(comment.body).to eq('Body')
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

  describe "delete '/api/v1/article/:article_id/comment/:id'" do
    let(:request) { delete api_v1_article_comment_path(article, params), {}, @env }

    context 'with valid parameters' do
      let(:params) { { id: comment.id } }

      it 'destroys the comment' do
        expect { request }.to change { article.comments.count }.by(-1)
      end

      it 'responds with no content status' do
        request
        expect(response.status).to eq(204)
      end
    end
  end
end
