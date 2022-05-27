Rails.application.routes.draw do
  resources :plants
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
