Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :clients
      #resources :tasks

      root to: "users#index"
  end
    
  devise_for :users
  
  root 'tasks#index'

  resources :tasks do
    collection do
      get :download
      get :chart
      get :calendar
    end  
  end  

end
