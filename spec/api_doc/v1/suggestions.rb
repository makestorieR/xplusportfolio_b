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


  
      
      end
    end
  end