Rails.application.routes.draw do
  
  namespace :api do 
    namespace :v1 do 
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users, only: [:index, :show] do 
        member do 
          get 'projects', to: 'users#projects_index'
          get 'suggestions', to: 'users#suggestions_index'
          get 'anticipations', to: 'users#anticipations_index'
          get 'followers', to: 'users#followers_index'
          get 'following', to: 'users#following_index'
        end
      end

      #project routes 
      resources :projects, only: [:create, :update, :destroy, :show]

      #anticipations routes 
      resources :anticipations, only: [:show, :update, :create]

    end
  end

end
