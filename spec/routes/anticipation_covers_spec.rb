require 'rails_helper'


RSpec.describe "AnticipationCovers", type: :routing do
  
    it "GET api/v1/anticipation_covers routes to api/v1/anticipation_covers#index" do
        expect(get '/api/v1/anticipation_covers').to route_to(controller: 'api/v1/anticipation_covers', action: 'index')  
    end

end
