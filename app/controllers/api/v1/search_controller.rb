class Api::V1::SearchController < ApplicationController
	 before_action :authenticate_api_v1_user!, only: [:index]


	def index 

		@results = []

		if params[:query] 
			@results = Searchkick.search params[:query] , { fields: ["title", "body", "name", "description"], misspellings: true,  models: [Project, Anticipation, User]}

		end

	end
end
