class Api::V1::NotesController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :create

	def create 

		note = current_api_v1_user.notes.create note_params

		 


		if note.save

			render json: note, status: :created

		else 

			render json: note.errors.messages, status: :unprocessable_entity
		end




	end


	private 

	def note_params 
		params.require(:note).permit(:content, :project_id)
	end
end
