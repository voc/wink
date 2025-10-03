Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :dashboard, :only => :show, :controller => :dashboard

  resources :cases do
    member do
      get :delete
    end
  end

  get '/events/import', to: 'events#import_events'
  resources :events do
    member do
      get :delete
    end
  end

  resources :check_lists, except: [:new, :create]
  resources :event_cases do
    resource :check_list, only: [:new, :create]
  end

  get '/transports/import', to: 'transports#import_transports'
  resources :transports do
    member do
      get :delete
    end
  end

  get '/items/export', to: 'items#export'
  resources :items do
    member do
      get :delete
      get :clone
    end

    resources :item_comments, shallow: true
  end

  resources :item_types do
    member do
      get :delete
    end
  end

  get    "/login",              to: "sessions#new",     as: :login
  post   "/auth/oidc",          to: "sessions#redirect", as: :auth_request
  get    "/auth/oidc/callback", to: "sessions#create"   # note provider in path
  get    "/auth/failure",       to: "sessions#failure"
  delete "/logout",             to: "sessions#destroy"

  root :to => 'root#show'
end
