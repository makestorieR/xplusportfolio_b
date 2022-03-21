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

        document :subscribers do
          action 'Get all users that have subscribed to anticipation'
        end


        document :likes do
          resource 'Likes' do
            endpoint '/likes'
            group 'Likes'
            desc 'likes.md'
          end
        end

        document :up do
          action 'Likes an anticipation'
        end

        document :down do
          action 'Unlikes an anticipation'
        end


  
      
      end
    end
  end