Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'guest_login', to: 'user_sessions#guest_login'
  get 'privacy', to: 'static_pages#privacy'
  get 'service', to: 'static_pages#service'
  get '/sitemap', to: redirect("https://s3-ap-northeast-1.amazonaws.com/reptiles-log/sitemaps/sitemap.xml.gz")

  resources :users, only: %i[new create index show] do
    collection do
      get :search
    end
  end
  resource :profile, only: %i[show edit update destroy] do
    collection do
      get :following, :followers
    end
    member do
      get :withdrawal
    end
  end
  resources :relationships, only: %i[create update destroy]
  resources :reptiles do
    resources :logs, only: %i[index new create destroy]
    resources :events, only: %i[index new create show destroy]
    resources :charts, only: %i[index]
  end
  resources :contacts, only: %i[new create]
  resources :password_resets, only: %i[new create edit update]
end
