Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :account, module: "accounts" do
    resource :profile, only: %i[show update]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  namespace :ui do
    resources :nav_group_items, only: %i[] do
      collection do
        get :account
      end
    end
  end
  # Defines the root path route ("/")
  root "home#root"
end
