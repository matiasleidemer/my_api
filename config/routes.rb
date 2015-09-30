Rails.application.routes.draw do
  devise_for :users

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :articles, except: [:new, :edit] do
        resources :comments, except: [:new, :edit]
      end
    end
  end
end
