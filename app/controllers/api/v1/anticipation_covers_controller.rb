class Api::V1::AnticipationCoversController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :index

	def index 

		@anticipation_covers = AnticipationCover.all

		render 'api/v1/anticipation_cover/index.json.jbuilder'
	end
end
