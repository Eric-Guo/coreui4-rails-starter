namespace :admin do
  resources :users, only: %i[index]
end
