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

      
    end
  end
end