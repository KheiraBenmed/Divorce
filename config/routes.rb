Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
  mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users
  root to: 'pages#home'
  resources :procedures do
    get 'zipcreate' => 'procedures#zipcreate'
  end
  resources :avocats do
    resources :contacts, only: [:create]
  end
  get 'avocats/search' => 'avocats#search'
  get 'testcamera' => 'procedures#testcamera'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
