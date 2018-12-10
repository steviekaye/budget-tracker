Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'purchases/index'

  get '/summary', to: 'purchases#summary'
  get '/category', to: 'category#index'

  resources :purchases do
  end

  resources :categories do
    resources :subcategories
  end

  root 'purchases#index'
end
