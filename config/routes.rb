Rails.application.routes.draw do
  devise_for :users

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :articles
    end
  end
end
