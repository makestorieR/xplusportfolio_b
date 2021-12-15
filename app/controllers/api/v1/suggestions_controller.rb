class Api::V1::SuggestionsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :update]
    before_action :validate_suggestion, only: :create
    before_action :find_suggestion, only: [:update]


    def create 

        suggestion = Suggestion.new suggestion_params
        suggestion.user = current_api_v1_user 

        if suggestion.save 
            NewSuggestionNotification.with(suggestion: suggestion).deliver_later suggestion.project.user
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

    def validate_suggestion 

        @project = Project.find_by_id(suggestion_params[:project_id])

        unless @project.user.id != current_api_v1_user.id 
            render json:{message: "User cannot create a suggestion for its own project"}, status: :unprocessable_entity
        end


    end



end
