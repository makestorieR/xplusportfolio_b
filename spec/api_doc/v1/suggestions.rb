module ApiDoc
    module V1
      module Suggestions
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Suggestion' do
            endpoint '/suggestions'
            group 'Suggestion'
            desc 'suggestions.md'
          end
        end

        document :create do
          action 'create a suggestion'
        end

        document :update do
          action 'update a suggestion'
        end

        document :mark_as_done do
          action 'update a suggestion done attribute to true'
        end
      
      end
    end
  end