Rails.application.routes.draw do
  resources :ingredients, only: [:index]
  resources :recipes, only: [:show]
end
