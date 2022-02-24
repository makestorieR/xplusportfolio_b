class Api::V1::UnfulfilledAnticipationsController < ApplicationController

	before_action :authenticate_api_v1_user!, only: :index


	def index 

		@anticipations = current_api_v1_user.anticipations.filter{|anti| anti.project.nil? }
		render 'api/v1/unfulfilled_anticipations/index.json.jbuilder'
	end
end
