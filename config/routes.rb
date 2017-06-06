Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  root 'documents#index'
  resources :procedures
  resources :avocats do
    resources :contacts, only: [:create]
  end
  get 'avocats/search' => 'avocats#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
