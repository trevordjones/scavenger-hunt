Rails.application.routes.draw do
  get '/' => 'jayci/scavengers#index'
  namespace :jayci do
    get '/' => 'scavengers#index'
    get '/scavenger/done' => 'scavengers#done'
    get '/scavenger/:id' => 'scavengers#show'
    patch '/scavenger/:id' => 'scavengers#update'
  end
end
