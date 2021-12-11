class Api::V1::NotificationsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: :index

    def index 

        @pagy, @notifications = pagy(current_api_v1_user.notifications, page: params[:page]) 
        render 'api/v1/notifications/index.json.jbuilder'
    end
end
