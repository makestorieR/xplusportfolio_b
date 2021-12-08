class Api::V1::AnticipationsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create]

    def create 
        anticipation = Anticipation.new anticipation_params
        anticipation.user = current_api_v1_user
        
        if anticipation.save 
            render json: anticipation, status: :created
        else
            render json: anticipation.errors.messages, status: :unprocessable_entity
        end
    end


    private 
    def anticipation_params 
        params.require(:anticipation).permit(:body, :anticipation_cover_id, :due_date)
    end
end
