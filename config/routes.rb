Rails.application.routes.draw do
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'guest_login', to: 'user_sessions#guest_login'
  get 'privacy', to: 'static_pages#privacy'
  get 'service', to: 'static_pages#service'
  get '/sitemap', to: redirect("https://#{ENV['AWS_DEFAULT_REGION']}.amazonaws.com/#{ENV['AWS_S3_BADGET_NAME']}/sitemaps/sitemap.xml.gz")

  resources :users, only: %i[new create index show] do
    collection do
      get :search
    end
  end
  resource :profile, only: %i[show edit update] do
    collection do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create update destroy]
  resources :reptiles do
    resources :logs, only: %i[index new create destroy]
    resources :events, only: %i[index new create show destroy]
    resources :charts, only: %i[index]
  end
  resources :contacts, only: %i[new create]
end
