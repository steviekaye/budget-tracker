Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'purchases/index'

  # get '/summaries', to: 'purchases#summary'
  # get '/category', to: 'categories#index'

  resources :purchases do
  end

  resources :summaries, only: %i[index show]

  resources :categories do
    resources :subcategories
  end

  root 'purchases#index'
end
