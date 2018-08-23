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

  resources :transports do
    member do
      get :delete
    end
  end

  get '/items/export', to: 'items#export'
  resources :items do
    member do
      get :delete
    end
  end

  root :to => 'root#show'
end
