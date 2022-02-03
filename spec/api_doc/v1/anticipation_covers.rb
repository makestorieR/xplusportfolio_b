module ApiDoc
  module V1
    module AnticipationCovers
      extend Dox::DSL::Syntax

      document :api do
        resource 'AnticipationCovers' do
          endpoint '/anticipation_covers'
          group 'AnticipationCovers'
          desc 'anticipation_covers.md'
        end
      end

      document :index do
        action 'Get AnticipationCovers'
      end






      

      
    end
  end
end