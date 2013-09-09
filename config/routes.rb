Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "videos#index"

  resources :videos do
    get "search", on: :collection
  end

  resources :users
end
