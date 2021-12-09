class Api::V1::SuggestionsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create]


    def create 

        suggestion = Suggestion.new suggestion_params
        suggestion.user = current_api_v1_user 

        if suggestion.save 
            render json: suggestion, status: :created
        else
            render json: suggestion.errors.messages, status: :unprocessable_entity
        end

    end

    private

    def suggestion_params 
        params.require(:suggestion).permit(:content, :project_id)
    end



end
