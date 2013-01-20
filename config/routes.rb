Events::Application.routes.draw do
  get "events/index"
  get "events/show"

  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'

  match "2013/:id" => "events#show", :constraints =>  { :year => /\d/ }


  resources :sessions
  namespace :admin do
    resources :events do
      resources :event_dates
      member do
        get :weight_move
      end
    end
    resources :event_places
  end

  match '/events/api.:format' => 'events#api'

  match ":eventtype" => "events#index"

  root :to => 'events#index'
end
