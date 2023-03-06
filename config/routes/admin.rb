namespace :admin do
  root to: "home#index"
  resources :users, only: %i[index edit update] do
    member do
      get :impersonation
      patch :sign_in_as
    end
  end
end
