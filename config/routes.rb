RailsBlog::Application.routes.draw do

  root 'posts#index'
  
  resources :sessions
  resources :users, :only => [:new, :show, :index]
  resources :tags, :only => [:show, :index]
  
  resources :posts do 
    resources :comments, :only => [:new, :create]
  end

  get '/auth/github/callback', to: 'sessions#create'
  get '/auth/github', as: :github_login
  get '/logout', to: 'sessions#destroy'


end
