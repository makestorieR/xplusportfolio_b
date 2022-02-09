class Api::V1::TechnologiesController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :index

	def index 	

		@technologies = Technology.all

		render 'api/v1/technologies/index.json.jbuilder'
	end
end
