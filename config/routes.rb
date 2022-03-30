require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'


  if Rails.env.production? 
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end

  end

  
  namespace :api do 
    namespace :v1 do 
      mount_devise_token_auth_for 'User', at: 'auth'

      #routes to search
      get 'search', to: 'search#index'

      #routes to all users activities 
      get 'all_activities', to: 'activities#index'

      #routes to my_activites 
      get 'user_activities', to: 'activities#user_activities'

      #routes to friends_activities 
      get 'friends_activities', to: 'activities#friends_activities'

      #routes to resources 
      get 'resources', to: 'resources#index'


      #route to retrieve anticipation covers
      get 'anticipation_covers', to: 'anticipation_covers#index'

      #route to retrieve user nofitications
      get 'notifications', to: 'notifications#index'

      #route to mark notification as read 
      put 'notifications/:id', to: 'notifications#mark_read'

      #route to mark all notifications
      get 'mark_all_notifications', to: 'notifications#mark_all'

      #routes to technologies 
      get 'technologies', to: 'technologies#index'

       #routes to top_projects 
      get 'top_projects', to: 'top_projects#index'

      #routes for web_push_notifications
      post 'web_push_notifications', to: 'web_push_notifications#create'

      #routes for updating user background_cover_photo
      put 'background_cover_photos', to: 'background_cover_photos#update'

      #route to get unfulfilled_anticipations 
      get 'unfulfilled_anticipations', to: 'unfulfilled_anticipations#index'

      #routes for the notes 
      resources :notes, only: [:create, :show]
      #users routes
      resources :users, only: [:index, :show, :update] do 
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
      resources :projects, only: [:create, :update, :destroy, :show, :index] do 

        member do 
          post 'likes', to: 'projects#up'
          delete 'likes', to: 'projects#down'
          post 'voters', to: 'projects#upvote'
          delete 'voters', to: 'projects#downvote'
          get 'suggestions', to: 'projects#suggestion_index'

        end

      end

      #anticipations routes 
      resources :anticipations, only: [:show, :update, :create] do 
        member do 
          post 'likes', to: 'anticipations#up'
          delete 'likes', to: 'anticipations#down'
          post 'suscribers', to: 'anticipations#suscribe'
          delete 'suscribers', to: 'anticipations#unsuscribe'
          get 'subscribers', to: 'anticipations#subscribers'

        end

      end

      #suggestions
      resources :suggestions, only: [:create, :update, :index] do 
        put 'complete', to: 'suggestions#mark_as_done'
        get 'suggestions', to: 'suggestions#index'

      end
      
    end
  end

end
