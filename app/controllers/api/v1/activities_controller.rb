class Api::V1::ActivitiesController < ApplicationController

	before_action :authenticate_api_v1_user!, only: [:index, :friends_activities, :user_activities]
	before_action :find_user, only: :user_activities

	def index 

		@pagy, @activities = pagy(PublicActivity::Activity.order(created_at: :desc), page: params[:page]) 
		render 'api/v1/activities/index.json.jbuilder'
	end

	def user_activities 
		
		@pagy, @activities = pagy(PublicActivity::Activity.order(created_at: :desc).where(owner_id: @user.id, owner_type: "User"), page: params[:page]) 
		render 'api/v1/activities/index.json.jbuilder'
	end

	def friends_activities 

		friends_id = (current_api_v1_user.followers_by_type('User') + current_api_v1_user.following_by_type('User')).map{|user| user.id}
		@pagy, @activities = pagy(PublicActivity::Activity.order(created_at: :desc).where(owner_id: friends_id, owner_type: "User"), page: params[:page]) 

		render 'api/v1/activities/index.json.jbuilder'
	end


	private 

	def find_user 



		@user = User.all.friendly.find_by_slug(params[:id]) 
		
        unless @user 
            render json: 'Not Found', message: "User does not exist", status: :not_found
        end
	end
end
