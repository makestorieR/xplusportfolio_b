module ApiDoc
    module V1
      module Anticipations
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Anticipation' do
            endpoint '/anticipations'
            group 'Anticipation'
            desc 'anticipations.md'
          end
        end
  
        document :show do
          action 'Get a anticipation'
        end
  
        document :update do
          action 'Update a anticipation'
        end
  
        document :create do
          action 'Create a anticipation'
        end
  
      
      end
    end
  end