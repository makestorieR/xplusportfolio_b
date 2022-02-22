module ApiDoc
    module V1
      module UnfulfilledAnticipations
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'UnfulfilledAnticipations' do
            endpoint '/unfulfilled_anticipations'
            group 'UnfulfilledAnticipations'
            desc 'unfulfilled_anticipations.md'
          end
        end

        document :index do
          action 'retrieves all UnfulfilledAnticipations'
        end
      
      end
    end
  end