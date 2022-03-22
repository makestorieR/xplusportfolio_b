require 'rails_helper'



RSpec.describe "Technologies", type: :routing do 

	describe "#GET" do 

		it "routes api/v1/top_projects/ to api/v1/top_projects#index" do 

			expect(get 'api/v1/top_projects/').to route_to('api/v1/top_projects#index')


		end

	end
end