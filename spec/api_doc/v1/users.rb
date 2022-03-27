module ApiDoc
  module V1
    module Users
      extend Dox::DSL::Syntax

      document :api do
        resource 'Users' do
          endpoint '/users'
          group 'Users'
          desc 'users.md'
        end
      end

      document :index do
        action 'Get users'
      end

      document :show do
        action 'Get a user'
      end

      document :update do 
        action 'Update a user'
      end

      document :projects do
        resource 'Projects' do
          endpoint '/projects'
          group 'Projects'
          desc 'projects.md'
        end
      end

      document :project_index do
        action 'Get a user Projects'
      end

      document :suggestion_index do
        action 'Get a user Suggestions'
      end

      document :anticipation_index do
        action 'Get a user Anticipations'
      end

      document :follower_index do
        action 'Get a user Followers'
      end

      document :following_index do
        action 'Get a user Followings'
      end

      document :up do
        action 'Follow User'
      end

      document :down do
        action 'Unfollow User'
      end





      

      
    end
  end
end