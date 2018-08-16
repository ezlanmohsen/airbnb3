Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  get 'reservations/index'
  get 'reservations/show'
  get 'reservations/new'
  #adding root
  root 'listings#index'

  get "/listings" => "listings#index"

  #for clearance
  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users 

  resources :listings do
    resources :reservations, except: [:index]
  end

  resources :reservations, only: [:index]

  post "/listings/:listing_id/reservations" => "reservations#create", as: "create_reservation"

  patch "/reservations/:id/approve" => "reservations#approve", as: "approve_reservation"

  get "/listings/:listing_id/reservations/:id/payment" => "reservations#payment", as: "pay_reservation"

  post "/listings/:listing_id/reservations/:id/payment/checkout" => "reservations#checkout", as: "checkout_pay_reservation"

  #placeholder verify to test admin role
  patch "/listings/:id/verify" => "listings#verify", as: "verify_listing"

  # Ask how to use existing route
  delete "/listings/:id" => "listings#destroy", as: "delete_listing"

  # post "/listings/:id/edit/" => "listings#edit", as: "listing_edit_listing"

  resources :tags

  post "/tags/create" => "tags#create", as: "create_tag"

  # resources :reservations

  # get "/:id/reservations/new" => "reservations#new", as: "new_reservation"
  

  #googleapi
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # for sidekiq


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end