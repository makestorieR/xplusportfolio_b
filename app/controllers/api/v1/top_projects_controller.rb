class Api::V1::TopProjectsController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :index

	def index 


		@projects = Project.all.first(5)

		render 'api/v1/top_projects/index.json.jbuilder'
	end
end
