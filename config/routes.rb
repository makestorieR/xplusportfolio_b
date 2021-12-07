Rails.application.routes.draw do
  
  namespace :api do 
    namespace :v1 do 
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users, only: [:index, :show] do 

      end

      #project routes 
      resources :projects, only: [:create, :update, :destroy, :show]

    end
  end

end
