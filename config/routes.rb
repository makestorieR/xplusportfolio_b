Rails.application.routes.draw do
  
  namespace :api do 
    namespace :v1 do 
      mount_devise_token_auth_for 'User', at: 'auth'

      #users routes
      resources :users, only: [:index, :show] do 
        member do 
          get 'projects', to: 'users#project_index'
          get 'suggestions', to: 'users#suggestion_index'
          get 'anticipations', to: 'users#anticipation_index'
          get 'followers', to: 'users#follower_index'
          get 'followings', to: 'users#following_index'
          post 'followings', to: 'users#up'
          delete 'followings', to: 'users#down'
        end
      end

      #project routes 
      resources :projects, only: [:create, :update, :destroy, :show]

      #anticipations routes 
      resources :anticipations, only: [:show, :update, :create] do 
        member do 
          post 'likes', to: 'anticipations#up'
          delete 'likes', to: 'anticipations#down'
          post 'suscribers', to: 'anticipations#suscribe'
          delete 'suscribers', to: 'anticipations#unsuscribe'
        end

      end

    end
  end

end
