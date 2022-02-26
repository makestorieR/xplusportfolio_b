class Api::V1::NotificationsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:index, :mark_read]

    def index 

    	if params[:status] && params[:status] === 'unread' 
    		
    		@notifications = current_api_v1_user.notifications.newest_first.unread
    	else 

    		 @pagy, @notifications = pagy(current_api_v1_user.notifications.newest_first, page: params[:page])
    	end
        
        render 'api/v1/notifications/index.json.jbuilder'
    end


    def mark_read 


    end
end
