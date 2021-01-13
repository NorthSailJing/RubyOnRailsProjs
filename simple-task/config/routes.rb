Rails.application.routes.draw do
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
