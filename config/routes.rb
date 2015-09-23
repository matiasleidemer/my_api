Rails.application.routes.draw do
  devise_for :users

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :articles do
        resources :comments
      end
    end
  end
end
