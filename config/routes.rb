# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :dashboard, only: :show, controller: :dashboard

  resources :cases do
    member do
      get :delete
    end
  end

  get "/events/import", to: "events#import_events"
  resources :events do
    member do
      get :delete
    end
  end

  resources :check_lists

  get "/transports/import", to: "transports#import_transports"
  resources :transports do
    member do
      get :delete
    end
  end

  get "/items/export", to: "items#export"
  resources :items do
    member do
      get :delete
      get :clone
    end

    resources :comments, controller: :item_comments
  end

  resources :item_types do
    member do
      get :delete
    end
  end

  root to: "root#show"
end
