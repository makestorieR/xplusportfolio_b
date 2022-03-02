class Api::V1::NotificationsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:index, :mark_read, :mark_all]

    def index 

    	if params[:status] && params[:status] === 'unread' 
    		
    		@notifications = current_api_v1_user.notifications.newest_first.unread
    	else 

    		 @pagy, @notifications = pagy(current_api_v1_user.notifications.newest_first, page: params[:page])
    	end
        
        render 'api/v1/notifications/index.json.jbuilder'
    end


    def mark_read 

    	@notification = Notification.find_by_id(params[:id])


    	if @notification
    		@notification.mark_as_read! 
    		render json: {total_notifications: current_api_v1_user.notifications.unread.size}, status: :ok
    	else 

    		render json: "Notification could not be found", status: :not_found

    	end
    end


    def mark_all 
    	current_api_v1_user.notifications.mark_as_read!
    	@notifications = current_api_v1_user.notifications.newest_first.unread
    	render 'api/v1/notifications/index.json.jbuilder'
    end
end
