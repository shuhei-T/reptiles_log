Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create index show]
  resource :profile, only: %i[show edit update] do
    collection do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :update, :destroy]
  resources :reptiles do
    resources :logs
    resources :events, only: %i[index new create show destroy]
    resources :charts, only: %i[index]
  end
end
