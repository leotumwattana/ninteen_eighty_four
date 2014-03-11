NinteenEightyFour::Application.routes.draw do

  root 'site#index'
  get  '/privacy' => 'site#privacy'
  get  '/terms'   => 'site#terms'
end
