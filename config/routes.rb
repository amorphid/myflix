Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resources :followers, only: [:create, :destroy]
  resources :users,     only: [:create, :new, :show]

  resources   :videos,  only: [:index, :show] do
    resources :queued_videos, only: [:create, :destroy]
    resources :reviews, only: [:create, :new]

    collection do
      post "search", to: "videos#search"
    end
  end

  delete "/sign_out", to: "sessions#destroy"

  get "confirm_password_reset", to: "static_pages#confirm_password_reset"
  get "forgot_password", to: "users#forgot_password"
  get "/home",     to: "videos#index"
  get "/my_queue", to: "queued_videos#index"
  get "/people",   to: "users#index"
  get "/sign_in",  to: "sessions#new"
  get "/sign_up",  to: "users#new"
  get "/sign_out", to: "sessions#destroy"

  post "reset_password", to: "users#reset_password"
  post "/sign_in",  to: "sessions#create"
  post "/my_queue", to: "queued_videos#update_all"

  root to: "static_pages#front"
end
