Rails.application.routes.draw do
  root to: "books#index"

  devise_for :users

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  resources :authors, concerns: :paginatable
  resources :books, concerns: :paginatable
  resources :primary_editions
  resources :editions
end
