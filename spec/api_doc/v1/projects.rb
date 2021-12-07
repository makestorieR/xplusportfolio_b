module ApiDoc
    module V1
      module Projects
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Projects' do
            endpoint '/projects'
            group 'Projects'
            desc 'projects.md'
          end
        end
  
        document :show do
          action 'Get a project'
        end
  
        document :update do
          action 'Update a project'
        end
  
        document :create do
          action 'Create a project'
        end
  
        document :destroy do
          action 'Delete a project'
        end
      end
    end
  end