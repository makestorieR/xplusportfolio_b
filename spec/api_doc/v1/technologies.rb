module ApiDoc
    module V1
      module Technologies
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Technologies' do
            endpoint '/technologies'
            group 'Technologies'
            desc 'technologies.md'
          end
        end

        document :index do
          action 'retrieves all Technologies'
        end
      
      end
    end
  end