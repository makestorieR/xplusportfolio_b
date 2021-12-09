class Api::V1::SuggestionsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :update]
    before_action :find_suggestion, only: [:update]


    def create 

        suggestion = Suggestion.new suggestion_params
        suggestion.user = current_api_v1_user 

        if suggestion.save 
            render json: suggestion, status: :created
        else
            render json: suggestion.errors.messages, status: :unprocessable_entity
        end

    end

    def update 
        if @suggestion.update(suggestion_params) 
            render json: @suggestion, status: :ok
        else
            render json: @suggestion.errors.messages, status: :unprocessable_entity
        end
    end

    private

    def suggestion_params 
        params.require(:suggestion).permit(:content, :project_id)
    end

    def find_suggestion
        @suggestion = Suggestion.find_by_id(params[:id])

        unless @suggestion 
            render json: {messages: "Suggestion not found"}, status: :not_found
        end
    end



end
