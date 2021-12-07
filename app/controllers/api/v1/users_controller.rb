class Api::V1::UsersController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:index, :show] 
    before_action :find_user, only: :show
   
    def index 
        
        if params[:page].present?
            @pagy, @users = pagy(User.all, page: params[:page])
        else
            @pagy, @users = pagy(User.all, page: 1)
        end

        render 'api/v1/users/index.json.jbuilder'
    end


    def show 

        render 'api/v1/users/show.json.jbuilder'
    end


    private 
    def find_user 

        @user = User.all.friendly.find_by_slug(params[:id]) 

        unless @user 
            render json: 'Not Found', message: "User does not exist", status: :not_found
        end
    end
end
