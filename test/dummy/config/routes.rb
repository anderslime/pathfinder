Rails.application.routes.draw do

  get '/news' => 'news#index'

  namespace :hello do
    post '/world' => "hello_world#index"
  end

  resources :locations

  get '/wildcard/*/route' => 'wildcards#index'

  mount Pathfinder::Engine => "/pathfinder"
end
