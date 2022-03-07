Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :users

    post '/auth/sign_in'
    post '/auth/renew'
    post '/auth/valid'
  end
end
