class Api::V1::NotesController < ApplicationController
	before_action :authenticate_api_v1_user!, only: [:create, :show]
	before_action :find_note, only: :show

	def create 

		note = current_api_v1_user.notes.create note_params

		if note.save

			render json: note, status: :created

		else 

			render json: note.errors.messages, status: :unprocessable_entity
		end




	end


	def show 

		render 'api/v1/notes/show.json.jbuilder'
	end





	private 

	def note_params 
		params.require(:note).permit(:content, :project_id)
	end


	def find_note 

		@note = current_api_v1_user.notes.find_by_id(params[:id])

		


		unless @note 
			render json: "Note not found", status: :not_found
		end
	end
end
