require 'rails_helper'


RSpec.describe "UnfulfilledAnticipations", type: :routing do
  
    it "GET api/v1/unfulfilled_anticipations routes to api/v1/unfulfilled_anticipations#index" do
        expect(get '/api/v1/unfulfilled_anticipations').to route_to(controller: 'api/v1/unfulfilled_anticipations', action: 'index')  
    end

end
