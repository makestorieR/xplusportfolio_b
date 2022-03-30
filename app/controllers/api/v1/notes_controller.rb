class Api::V1::NotesController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :create

	def create 


	end
end
