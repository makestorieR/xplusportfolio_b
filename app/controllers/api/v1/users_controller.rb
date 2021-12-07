class Api::V1::UsersController < ApplicationController

    def index 
        @users = User.all
        render 'api/v1/users/index.json.jbuilder'
    end
end
