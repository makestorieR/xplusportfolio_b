class Api::V1::UsersController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:index] 
   
    def index 
        
        if params[:page].present?
            @pagy, @users = pagy(User.all, page: params[:page])
        else
            @pagy, @users = pagy(User.all, page: 1)
        end

        render 'api/v1/users/index.json.jbuilder'
    end
end
