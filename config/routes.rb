require 'sidekiq/web'

NinteenEightyFour::Application.routes.draw do

  root 'site#index'

  get     'login'  => 'session#new'
  post    'login'  => 'session#create'
  delete  'logout' => 'session#destroy'

  get   'reset/:code' => 'password#edit', as: :reset
  put   'reset/:code' => 'password#update'
  patch 'reset/:code' => 'password#update'

  resources :users
  resources :bmails

  get 'sent' => 'bmail#sent', as: :sent
  get 'cancel/:id' => 'bmail#cancel', as: :cancel

  mount Sidekiq::Web, at: '/sidekiq'

  get '/privacy' => 'site#privacy'
  get '/terms'   => 'site#terms'
end
