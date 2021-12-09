class Api::V1::ProjectsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :update, :destroy, :show, :upvote, :downvote, :up]
    before_action :find_project, only: [:upvote, :downvote, :up] 
    before_action :find_project_by_user, only: [:update, :destroy, :show]

    def create 

        @project = Project.new project_params
        @project.user = current_api_v1_user

        if @project.save 
            render json: @project, status: :created
        else
            render json: @project.errors.messages, status: :unprocessable_entity
        end

    end


    def update 

        if @project.update(project_params)
            render json: @project, status: :ok
        else
            render json: @project.errors.messages, status: :unprocessable_entity
        end
    end


    def destroy 
        @project.destroy
    end


    def show 
        render 'api/v1/projects/show.json.jbuilder'
    end

    def upvote 
        @project.vote_by voter: current_api_v1_user
        render json: {message: "Succesfully Voted for project", total_votes: @project.weighted_score}, status: :ok
    end

    

    def downvote 
        @project.downvote_from current_api_v1_user
        render json: {message: "Downvoted project", total_votes: @project.weighted_score}, status: :ok
    end


    def up 
        current_api_v1_user.likes @project
        render json: {message: "Liked this project", total_likes: @project.get_likes.size}, status: :ok
    end

    private

    def project_params 
        params.require(:project).permit(:title, :description)
    end

    def find_project_by_user
        @project = current_api_v1_user.projects.friendly.find_by_slug(params[:id])
        
        unless @project 
            render json: "Not Found", message: "Project not found", status: :not_found
        end
    end

    def find_project 
        @project = Project.friendly.find_by_slug(params[:id])
        
        unless @project 
            render json: "Not Found", message: "Project not found", status: :not_found
        end
    end
end
