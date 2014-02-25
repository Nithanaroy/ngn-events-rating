Events::Application.routes.draw do
  resources :events
  resources :sessions
  post 'events/:id/rating' => 'events#add_rating'
  post 'events/:id/going' => 'events#going'
  match '/auth/:provider/callback' => 'sessions#create', :via => [:get, :post]
  delete 'sessions/destroy' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure' 

  root 'static_pages#welcome'
  get '/about' => 'static_pages#about'
end
