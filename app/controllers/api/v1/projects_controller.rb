class Api::V1::ProjectsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create, :update, :destroy, :show]
    before_action :find_project, only: [:update, :destroy, :show]

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

    private

    def project_params 
        params.require(:project).permit(:title, :description)
    end

    def find_project 
        @project = current_api_v1_user.projects.friendly.find_by_slug(params[:id])
        
        unless @project 
            render json: "Not Found", message: "Project not found", status: :not_found
        end
    end
end
