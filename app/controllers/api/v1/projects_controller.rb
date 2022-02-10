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

            photos = []
            technology_ids = params[:tools].split(",").map{|id| id.to_i}
            project = JSON.parse(params[:project]).with_indifferent_access


            succesfull = false 
        
            params.each do |key, value|
              
              photos.push(value) if key.include?('image') && value.class == ActionDispatch::Http::UploadedFile
            end

            


            @project = Project.new 
            @project.title = project[:title]
            @project.description = project[:description]
            @project.user = current_api_v1_user
            @project.github_link = project[:githubLink]
            @project.live_link = project[:liveLink]


            Project.transaction(requires_new: true) do 
                ProjectPhoto.transaction(requires_new: true) do 
                    Tool.transaction(requires_new: true) do 

                        raise ActiveRecord::Rollback if !@project.save 

                        photos.each do |photo|  

                            result = Cloudinary::Uploader.upload(photo, :folder => "#{current_api_v1_user.name}/projects/")
                            ProjectPhoto.create img_url: result["url"], project: @project


                        end

                        technology_ids.each do |tech_id|  
                            Tool.create technology_id: tech_id, project: @project

                        end

                        if @project.save 
                            succesfull = true 
                        end



                    end

                    

                end


            end

         

            
         

        
        
        if succesfull 
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
