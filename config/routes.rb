# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :dashboard, only: :show, controller: :dashboard

  resources :cases

  get "/events/import", to: "events#import_events"
  resources :events

  resources :check_lists

  get "/transports/import", to: "transports#import_transports"
  resources :transports

  get "/items/export", to: "items#export"
  resources :items do
    member do
      get :clone
    end

    resources :comments, controller: :item_comments
  end

  resources :item_types
  resources :case_types

  root to: "root#show"
end
