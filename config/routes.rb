Eachfund::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  resources :friendships 

  get ':controller/:action/:id'

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "authentications"}
  resources :users
  resources :messages
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
end
