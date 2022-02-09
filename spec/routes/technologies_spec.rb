require 'rails_helper'



RSpec.describe "Technologies", type: :routing do 

	describe "#GET" do 

		it "routes api/v1/technologies/ to api/v1/technologies#index" do 

			expect(get 'api/v1/technologies/').to route_to('api/v1/technologies#index')


		end

	end
end