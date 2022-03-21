require 'rails_helper'


RSpec.describe "BackgroundCoverPhotos", type: :routing do
  
    it "PUT api/v1/background_cover_photos routes to api/v1/background_cover_photos#update" do
        expect(put '/api/v1/background_cover_photos').to route_to(controller: 'api/v1/background_cover_photos', action: 'update')  
    end

end
