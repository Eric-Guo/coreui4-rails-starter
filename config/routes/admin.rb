namespace :admin do
  resources :users, only: %i[index edit update] do
    member do
      get :impersonation
      patch :sign_in_as
    end
  end
end
