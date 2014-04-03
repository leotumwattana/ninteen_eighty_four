require 'sidekiq/web'

NinteenEightyFour::Application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  resources :users
  resources :bmails

  root 'site#index'

  get     'login'  => 'session#new'
  post    'login'  => 'session#create'
  delete  'logout' => 'session#destroy'

  get   'reset/:code' => 'password#edit', as: :reset
  patch 'reset/:code' => 'password#update'

  get 'sent' => 'bmails#sent', as: :sent
  get 'cancel/:id' => 'bmails#cancel', as: :cancel

  get '/privacy' => 'site#privacy'
  get '/terms'   => 'site#terms'
end
