Rails.application.routes.draw do
  resources :preferences
  resources :rounds
  resources :result_submissions
  resources :users do
    collection do
      get :login
    end
  end
  resources :landing, only: [:index]
  resources :user_select, only: [:index] do
    post :generate_login_key
    collection do
      post :assign_user
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'landing#index'
end
