class Api::V1::ResourcesController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :index

	def index 


		@resources = Resource.where(resource_type: params[:resource_type])

		render 'api/v1/resources/index.json.jbuilder'
	end
end
