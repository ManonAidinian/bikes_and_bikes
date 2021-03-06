Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get '/dashboard',              to: 'pages#dashboard'
  resources :bikes, only: %w[index show new create edit update] do
    resources :bookings, only: [:create]
  end
  # get '/bikes',                  to: 'bikes#index'
  # get '/bike/:id',               to: 'bikes#show'
  # get '/bikes/new',               to: 'bikes#new'
  # post '/bikes/new',              to: 'bikes#create'
  # get '/bikes/:id/edit',          to: 'bikes#edit'
  # patch '/bikes/:id/edit',        to: 'bikes#update'

  # I doubt that we need the following.
  # Maybe we can do that right from the bikes#show, after clicking "Book now!"
  get '/bookings/:id/new_review',  to: 'bookings#new_review'
  post '/bookings/:id/new_review', to: 'bookings#create_review'

  get '/styleguide', to: 'pages#styleguide'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
