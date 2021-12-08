class Api::V1::AnticipationsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :update, :show]
    before_action :find_anticipation, only: [:update, :show]
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
        
        render 'api/v1/anticipations/show.json.jbuilder'
    end

    def update 

        if @anticipation.update(anticipation_params) 
            render json: @anticipation, status: :ok
        else
            render json: @anticipation.errors.messages, status: :unprocessable_entity
        end
    end


    private 
    def anticipation_params 
        params.require(:anticipation).permit(:body, :anticipation_cover_id, :due_date)
    end

    def find_anticipation 
        @anticipation = current_api_v1_user.anticipations.find_by_slug(params[:id])
        
        unless @anticipation 
            render json: "Not Found", message: "Project not found", status: :not_found
        end
    end
end
