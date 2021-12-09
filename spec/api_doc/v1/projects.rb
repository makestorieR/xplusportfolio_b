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

        document :index do
          action 'Get projects'
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

        document :api do
          resource 'Voters' do
            endpoint '/voters'
            group 'Voters'
            desc 'voters.md'
          end
        end

        document :upvote do
          action 'Vote a project'
        end

        document :downvote do
          action 'Downvote a project'
        end

        document :api do
          resource 'likes' do
            endpoint '/likes'
            group 'likes'
            desc 'likes.md'
          end
        end

        document :up do
          action 'Like a project'
        end

        document :down do
          action 'Unlike a project'
        end


        document :api do
          resource 'suggestions' do
            endpoint '/suggestions'
            group 'suggestions'
            desc 'suggestions.md'
          end
        end

        document :suggestion_index do
          action 'Get suggestions'
        end




      end
    end
  end