Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get "home", to: "movies#index"

  resources :videos
end
