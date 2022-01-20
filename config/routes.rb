Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :reptiles, shallow: true do
    resources :daily_records, only: %i[index] do
      resources :logs, only: %i[new create destroy]
    end
  end
end
