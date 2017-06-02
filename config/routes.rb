Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :procedures
  resources :avocats
  get 'avocats/search' => 'avocats#search'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
