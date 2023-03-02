namespace :admin do
  resources :users, only: %i[index edit update] do
    member do
      post :sign_in_as
    end
  end
end
