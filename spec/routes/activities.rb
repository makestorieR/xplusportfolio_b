require 'rails_helper'



RSpec.describe "Activities", type: :routing do 

	describe "#GET" do 

		it "routes api/v1/all_activities/ to api/v1/all_activities#index" do 

			expect(get 'api/v1/all_activities/').to route_to('api/v1/activities#index')


		end

	end

	describe "#GET" do 

		it "routes api/v1/friends_activities/ to api/v1/activities#friends_activities" do 

			expect(get 'api/v1/friends_activities/').to route_to('api/v1/activities#friends_activities')


		end

	end

	describe "#GET" do 

		it "routes api/v1/user_activities/ to api/v1/activities#user_activities" do 

			expect(get 'api/v1/user_activities/').to route_to('api/v1/activities#user_activities')


		end

	end
end