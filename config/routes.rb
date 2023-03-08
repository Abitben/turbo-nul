Rails.application.routes.draw do
  resources :emails
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'emails#index'

  get '/email/test', to: 'emails#test'
end
