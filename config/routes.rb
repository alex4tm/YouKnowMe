Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get dashboard from the profile controller with method dashboard
  get "/dashboard", to: 'profile#dashboard'
  get "/my_bookings", to: 'profile#my_bookings'
  get "/edit_profile", to: 'profile#edit_profile'

  resources :categories, except: [:show] do
    resources :preferences, except: [:show]
  end
  resource :restaurants, only: [:show] do
  end
  resources :bookings, only: [:new, :create, :index] do
    collection do
      get :available
    end
  end

  patch '/reset_uid', to: 'categories#reset_uid'
end
