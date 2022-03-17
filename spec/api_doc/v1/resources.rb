module ApiDoc
    module V1
      module Resources
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Resources' do
            endpoint '/resources'
            group 'Resources'
            desc 'resources.md'
          end
        end
  
        document :index do
          action 'Get resources'
        end


      
      end
    end
  end