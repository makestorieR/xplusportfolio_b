class Api::V1::SuggestionsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :update, :mark_as_done]
    before_action :validate_suggestion, only: :create
    before_action :find_suggestion, only: [:update]
    before_action :ensure_done_attribute, only: [:update]
    before_action :find_suggestion_to_be_completed, only: [:mark_as_done]
    before_action :ensure_only_project_owner, only: [:mark_as_done]
    


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

    def mark_as_done 
        if @suggestion.update!(done: true) 
            render json: @suggestion, status: :ok
        end
    end

    private

    def suggestion_params 
        params.require(:suggestion).permit(:content, :project_id, :done)
    end

    def find_suggestion
        @suggestion = Suggestion.find_by_id(params[:id])

        unless @suggestion 
            render json: {messages: "Suggestion not found"}, status: :not_found
        end
    end

    def find_suggestion_to_be_completed 
        @suggestion = Suggestion.find_by_id(params[:suggestion_id])

        unless @suggestion 
            render json: {messages: "Suggestion not found"}, status: :not_found
        end
    end

    def ensure_done_attribute
        #makes sure that done params is not passed when trying to update the suggestion by the user that created it.
         if suggestion_params[:done].present?
            render json: {message: "Not Permitted to update the done attribute"}, status: :unprocessable_entity
         end
    end

    def validate_suggestion 
        #ensure that the user creating the suggestion is not the user that created the project
        @project = Project.find_by_id(suggestion_params[:project_id])

        unless @project.user.id != current_api_v1_user.id 
            render json:{message: "User cannot create a suggestion for its own project"}, status: :unprocessable_entity
        end

    end

    def ensure_only_project_owner
        #ensures that only project owner is able to complete suggestion made by other users

        if @suggestion.user.id == current_api_v1_user.id 

            render json: {message: "Only Project owner are allowed to complete suggestions"}, status: :unauthorized

        end


    end



end
