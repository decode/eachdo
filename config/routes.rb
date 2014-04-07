Eachfund::Application.routes.draw do

  root "home#index"

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

  get ':controller/:action/:id'
end
