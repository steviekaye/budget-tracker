Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'purchases/index'

  post 'limit' => 'purchases#limit'

  resources :purchases, only: %i[index new create]

  resources :summaries, only: %i[index show]

  resources :categories, only: %i[create index destroy update] do
    resources :subcategories, only: %i[create destroy update]
  end

  root 'purchases#index'
end
