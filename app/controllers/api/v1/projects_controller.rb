class Api::V1::ProjectsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :index, :update, :destroy, :show, :upvote, :downvote, :up, :down, :suggestion_index]
    before_action :find_project, only: [:upvote, :downvote, :up, :down, :suggestion_index] 
    before_action :find_project_by_user, only: [:update, :destroy, :show]


    def index 

        if params[:page].present?  
              
            @pagy, @projects = pagy(current_api_v1_user.projects, page: params[:page]) 
        else
            @pagy, @projects = pagy(current_api_v1_user.projects, page: 1) 
        end

        render 'api/v1/projects/index.json.jbuilder'

    end

    def create 

        @project = Project.new project_params
        @project.user = current_api_v1_user
        
        if @project.save 
            NewProjectJob.perform_later(@project.id)
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
        UpvoteNotification.with(project: @project).deliver_later @project.user
        render json: {message: "Succesfully Voted for project", total_votes: @project.weighted_score}, status: :ok
    end

    

    def downvote 
        @project.downvote_from current_api_v1_user
        render json: {message: "Downvoted project", total_votes: @project.weighted_score}, status: :ok
    end


    def up 
        current_api_v1_user.likes @project
        ProjectLikeNotification.with(project: @project).deliver @project.user
        render json: {message: "Liked this project", total_likes: @project.get_likes.size}, status: :ok
    end

    def down 
        current_api_v1_user.unlike @project
        render json: {message: "Unlikes this project", total_likes: @project.get_likes.size}, status: :ok
    end

    def suggestion_index 
        

        if params[:page].present?  
              
            @pagy, @suggestions = pagy(@project.suggestions.includes(:user), page: params[:page]) 
        else
            @pagy, @suggestions = pagy(@project.suggestions.includes(:user), page: 1) 
        end
        render 'api/v1/projects/suggestion_index.json.jbuilder'
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
