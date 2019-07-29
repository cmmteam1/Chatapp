Rails.application.routes.draw do

  scope "(:locale)", locale: /en|ja/ do

  root   'session#new'
  # get    '/help',    to: 'static_pages#help'
  # get    '/about',   to: 'static_pages#about'
  # get    '/contact', to: 'static_pages#contact'
  
  get '/signup', to: 'users#new'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/logout',  to: 'session#destroy'
 
  # root 'channels#index'
  resources :session
  resources :users
  resources :invite
  resources :messages
  resources :channels
  resources :workspaces
  resources :thread_messages
  
  resources :channels do
  resources :invite
  end
  
  resources :workspaces do
  resources :userwork
  end
  
  resources :workspaces do
   resources :channels
  end
  
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
