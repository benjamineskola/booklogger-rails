Rails.application.routes.draw do
  root to: "books#currently_reading"

  devise_for :users

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  get "books/reading", to: "books#currently_reading"
  get "books/reading/page/:page", to: "books#currently_reading"
  get "books/toread", to: "books#toread"
  get "books/toread/page/:page", to: "books#toread"
  get "books/wishlist", to: "books#wishlist"
  get "books/wishlist/page/:page", to: "books#wishlist"

  resources :authors, concerns: :paginatable
  resources :books, concerns: :paginatable
  resources :primary_editions
  resources :editions
end
