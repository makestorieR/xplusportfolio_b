class Api::V1::BackgroundCoverPhotosController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :update
	def update 

		

		if current_user_api_v1_user.background_cover_photo.update(img_url: result['url'])

			render json: "Succesfully Updated the background photo ", status: :ok

		else
			render json: "Failed to update the background photo", status: :unprocessable_entity
		end


	end
end
