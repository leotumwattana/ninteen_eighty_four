NinteenEightyFour::Application.routes.draw do

  root 'site#index'

  get     'login'  => 'session#new'
  post    'login'  => 'session#create'
  delete  'logout' => 'session#destroy'
  get     'logout' => 'session#destroy' # TODO: Remove before deployment

  get '/privacy' => 'site#privacy'
  get '/terms'   => 'site#terms'
end
