module ApiDoc
    module V1
      module Notes
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Note' do
            endpoint '/notes'
            group 'Note'
            desc 'notes.md'
          end
        end

        document :create do
          action 'create a note'
        end

        document :update do
          action 'update a note'
        end


        document :show do
          action 'get a note'
        end

      end
    end
  end