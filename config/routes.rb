Rails.application.routes.draw do
  resources :articles, only: :index
  resources :searches, only: :index

  root "articles#index"
end
