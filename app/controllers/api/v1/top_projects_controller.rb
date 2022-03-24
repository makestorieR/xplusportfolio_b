class Api::V1::TopProjectsController < ApplicationController
	before_action :authenticate_api_v1_user!, only: :index

	def index 


		sorted_projects = Project.all.map do |project|

			{project_id: project.id, total_upvotes: project.get_upvotes.size}


		end

		sorted_projects.sort_by! { |k| -k[:total_upvotes] }
		project_ids = sorted_projects.map{|p| p[:project_id]}
		@projects = Project.where(id: project_ids).limit(5)


		render 'api/v1/top_projects/index.json.jbuilder'
	end
end
