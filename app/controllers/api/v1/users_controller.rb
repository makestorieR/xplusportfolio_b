class Api::V1::UsersController < ApplicationController
    before_action :authenticate_api_v1_user!, only: [:index, :show, :update, :project_index, :suggestion_index, :anticipation_index, :follower_index, :following_index, :up, :down] 
    before_action :find_user, only: [:show, :update, :project_index, :suggestion_index, :anticipation_index, :follower_index, :following_index, :up, :down]
    before_action :check_follow_status, only: :up
    def index 
        if params[:page].present?
            @pagy, @users = pagy(User.all, page: params[:page])
        else
            @pagy, @users = pagy(User.all, page: 1)
        end
        render 'api/v1/users/index.json.jbuilder'
    end

    def update 


        result = Cloudinary::Uploader.upload(params[:backcover_imgurl], height: 150, :folder => "#{current_api_v1_user.name}/background_cover_photos/") if params[:backcover_imgurl] 
        


        @user.backcover_imgurl = result['url'] if params[:backcover_imgurl]

        @user.github_url = params[:github_url]
        @user.avatar_url = params[:avatar_url]
        @user.name = params[:name]


        if @user.save
            render json: @user, status: :ok
        else

            render json: @user.errors.messages, status: :unprocessable_entity
        end
            


    end


    def show 
        @total_project_votes = @user.projects.reduce(0) { |sum, project| sum + project.get_upvotes.size }

        total_anticipation_fulfilled = 0

    
        render 'api/v1/users/show.json.jbuilder'
    end

    def project_index 
       @projects = @user.projects.includes(:user, :project_photos, :tools).order(created_at: 'desc') 

        render 'api/v1/projects/index.json.jbuilder'
    end

    def anticipation_index 
        

        @anticipations = @user.anticipations.includes(:anticipation_cover, :anticipation_cover, :user, :project).order(created_at: 'desc') 
        
        render 'api/v1/users/anticipation_index.json.jbuilder'
    end


    def suggestion_index

        @suggestions = @user.suggestions.includes(:user).order(created_at: 'desc') 
        render 'api/v1/users/suggestion_index.json.jbuilder'
    end

    def follower_index 
   
        @followers = followers.order(created_at: 'desc') 
        render 'api/v1/users/follower_index.json.jbuilder'
    end

    def following_index 
        
        @follows = following.order(created_at: 'desc') 
        render 'api/v1/users/following_index.json.jbuilder'
    end

    def up 

        
        current_api_v1_user.follow @user
        render json: {message: "Started Following #{@user.name}"}, status: :ok
    end

    def down 
        current_api_v1_user.stop_following @user
        render json: {message: "Stopped Following #{@user.name}"}, status: :ok
    end

 
    private 
    def find_user 

        
        @user = User.all.find_by_slug(params[:id])
        unless @user 
            render json: 'Not Found', message: "User does not exist", status: :not_found
        end
    end

    def check_follow_status 
        unless !current_api_v1_user.following? @user 
            render json: {message: "User Already Been Followed"}, status: :unprocessable_entity
        end
    end

    def followers 
        @user.followers_by_type("User")
    end

    def following 
        @user.following_by_type("User")
    end
end
