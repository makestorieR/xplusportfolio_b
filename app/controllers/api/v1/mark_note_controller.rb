class Api::V1::MarkNoteController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :update
	before_action :find_note, only: :update


	def update 

		@note.update(seen: true) 

		render json: @note, status: :ok
	end


	private 

	def find_note 

		@note = current_api_v1_user.notes.find_by_id(params[:id])

		unless @note 
			render json: "Note could not be found", status: :not_found

		end
	end
end
