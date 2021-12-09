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

        document :suscribers do
          resource 'Suscirbers' do
            endpoint '/suscribers'
            group 'Suscirbers'
            desc 'suscribers.md'
          end
        end



        document :suscribe do
          action 'Suscribe to anticipation'
        end

        document :unsuscribe do
          action 'Unsuscribe from anticipation'
        end


  
      
      end
    end
  end