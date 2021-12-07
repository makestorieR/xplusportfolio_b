class Api::V1::ProjectsController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:create]

    def create 

        @project = Project.new project_params
        @project.user = current_api_v1_user

        if @project.save 
            render json: @project, status: :created
        else
            render json: @project.errors.messages, status: :unprocessable_entity
        end

    end

    private

    def project_params 
        params.require(:project).permit(:title, :description)
    end
end
