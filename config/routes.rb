Rails.application.routes.draw do
  devise_for :users

  get root,                       to: 'pages#home'
  get '/dashboard/',              to: 'pages#dashboard'
  get '/bikes/',                  to: 'bikes#index'
  get '/bikes/:id',               to: 'bikes#show'
  get '/bikes/new',               to: 'bikes#new'
  post '/bikes/new',              to: 'bikes#create'
  get '/bikes/:id/edit',          to: 'bikes#edit'
  patch '/bikes/:id/edit',        to: 'bikes#update'

  # I doubt that we need the following.
  # Maybe we can do that right from the bikes#show, after clicking "Book now!"
  get '/booking/new',             to: 'booking#new'
  post '/booking/new',            to: 'booking#create'
  get '/booking/:id/new_review',  to: 'booking#new_review'
  post '/booking/:id/new_review', to: 'booking#create_review'

  get '/styleguide', to: 'pages#styleguide'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
