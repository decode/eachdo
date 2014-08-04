Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root "home#index"

  resources :feedbacks do
    member do
      get :filter
    end
  end

  resources :orders do
    resources :feedbacks
    member do
      get :filter
    end
  end

  resources :prices

  resources :houses do
    resources :prices
    resources :orders
    resources :feedbacks
  end

  resources :photos

  resources :albums do
    resources :photos
  end


  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "authentications"}
  resources :users
  resources :messages
  #resources :friendships 
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
      post :mark_as_deleted
      get  :filter
    end
    collection do
      delete 'destroy_multiple'
    end
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount ChinaCity::Engine => '/china_city'

  post '/city', to: 'houses#list_city'
  get '/district(/:region)', to: 'houses#list_district'
  get ':controller/:action(/:id)'
end
