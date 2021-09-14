Rails.application.routes.draw do
  resources :ingredients, only: [:index]
  resources :recipes, only: [:show] do
    resources :ingredients, only: [:show, :index, :create]
  end
end
