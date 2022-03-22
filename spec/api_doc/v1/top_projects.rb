module ApiDoc
    module V1
      module TopProjects
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'TopProjects' do
            endpoint '/top_projects'
            group 'TopProjects'
            desc 'top_projects.md'
          end
        end

        document :index do
          action 'retrieves all TopProjects'
        end
      
      end
    end
  end