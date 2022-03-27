

class Api::V1::BackgroundCoverPhotosController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :update
	def update 

		result = Cloudinary::Uploader.upload(params[:image], height: 150, :folder => "#{current_api_v1_user.name}/background_cover_photos/")
		
		@background_cover_photo = current_api_v1_user.background_cover_photo
		@background_cover_photo.img_url = result['url']

		current_api_v1_user.backcover_imgurl = result['url']
			


		if current_api_v1_user.save!


			render json: {url: result['url']}, status: :ok

		else
			render json: "Failed to update the background photo", status: :unprocessable_entity
		end


	end
end


