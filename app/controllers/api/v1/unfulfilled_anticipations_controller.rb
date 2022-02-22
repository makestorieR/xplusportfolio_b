class Api::V1::UnfulfilledAnticipationsController < ApplicationController

	before_action :authenticate_api_v1_user!, only: :index


	def index 

		# json.expired Time.now > anticipation.due_date 
  #   json.fulfilled !anticipation.project.nil?
  #   json.total_subscribers anticipation.followers_count
  #   json.total_likes anticipation.get_likes.size
  #   json.is_subscribed current_api_v1_user.following?(anticipation)
  #   json.a_slug anticipation.slug
  #   json.defaulted (Time.now > anticipation.due_date && anticipation.project.nil?)

		@anticipations = current_api_v1_user.anticipations
		render 'api/v1/unfulfilled_anticipations/index.json.jbuilder'
	end
end
