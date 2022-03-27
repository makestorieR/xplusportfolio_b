class Api::V1::UnfulfilledAnticipationsController < ApplicationController

	before_action :authenticate_api_v1_user!, only: :index


	def index 

		@anticipations = current_api_v1_user.anticipations.order(created_at: 'desc').filter{|anti| !(Time.now > anti.due_date) &&  anti.project.nil? }


		render 'api/v1/unfulfilled_anticipations/index.json.jbuilder'
	end
end
