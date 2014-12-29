Rails.application.routes.draw do

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/forums'


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
  resources :friendships 
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
