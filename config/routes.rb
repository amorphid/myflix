Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resources :users,         only: [:create, :new]

  resources   :videos,  only: [:index, :show] do
    resources :queued_videos, only: [:create, :destroy]
    resources :reviews, only: [:create, :new]

    collection do
      post "search", to: "videos#search"
    end
  end

  delete "/sign_out", to: "sessions#destroy"

  get "/home",     to: "videos#index"
  get "/my_queue", to: "queued_videos#index"
  get "/sign_in",  to: "sessions#new"
  get "/sign_up",  to: "users#new"
  get "/sign_out", to: "sessions#destroy"

  post "/sign_in", to: "sessions#create"

  root to: "static_pages#front"
end
