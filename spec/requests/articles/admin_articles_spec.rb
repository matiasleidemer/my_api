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
end
