module ApiDoc
    module V1
      module Searchs
        extend Dox::DSL::Syntax
  
        document :api do
          resource 'Search' do
            endpoint '/search'
            group 'Search'
            desc 'search.md'
          end
        end

        document :index do
          action 'search for data'
        end




      
      end
    end
  end