namespace :admin do
  resources :users, only: %i[index] do
    member do
      post :sign_in_as
    end
  end
end
