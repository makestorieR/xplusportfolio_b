class Api::V1::AnticipationsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :update, :show, :suscribe]
    before_action :find_user_anticipation, only: [:update, :show]
    before_action :find_anticipation, only: [:suscribe]
    before_action :check_suscribtion_status, only: [:suscribe]
    def create 
        anticipation = Anticipation.new anticipation_params
        anticipation.user = current_api_v1_user
        
        if anticipation.save            
            render json: anticipation, status: :created
        else
            render json: anticipation.errors.messages, status: :unprocessable_entity
        end
    end

    def show 
        @pagy, @suscribers = pagy(suscribers, page: params[:page])
        render 'api/v1/anticipations/show.json.jbuilder'
    end

    def update 
        if @anticipation.update(anticipation_params) 
            render json: @anticipation, status: :ok
        else
            render json: @anticipation.errors.messages, status: :unprocessable_entity
        end
    end

    def suscribe 
        
        current_api_v1_user.follow @anticipation
        render json: {message: "Succesfully suscribed to this anticipation"}, status: :ok
    end


    private 
    def anticipation_params 
        params.require(:anticipation).permit(:body, :anticipation_cover_id, :due_date)
    end

    def suscribers 
        @anticipation.followers_by_type("User")
    end

    def find_user_anticipation 
        @anticipation = current_api_v1_user.anticipations.find_by_slug(params[:id])
        unless @anticipation 
            render json: "Not Found", message: "Project not found", status: :not_found
        end
    end

    def find_anticipation 
        
        @anticipation = Anticipation.find_by_slug(params[:id])

        
        unless @anticipation 
            render json: "Not Found", message: "Project not found", status: :not_found
        end
    end

    def check_suscribtion_status
        unless !current_api_v1_user.following? @anticipation 
            render json: {message: "User already a suscriber"}, status: :unprocessable_entity
        end
    end

    def followers 
        @user.followers_by_type("User")
    end
end
