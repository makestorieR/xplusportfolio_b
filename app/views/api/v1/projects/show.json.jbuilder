
json.project do 

    json.(@project, :slug, :title, :description)

    json.(@project, :title, :slug, :github_link, :live_link, :created_at)
    json.total_likes @project.get_likes.size
    json.total_votes @project.get_upvotes.size
    json.description @project.description

    json.liked @project.get_likes.where(voter_id: current_api_v1_user).exists?
    json.voted @project.get_upvotes.where(voter_id: current_api_v1_user).exists?
    json.total_suggestions @project.suggestions.size	



    json.project_photos @project.project_photos do |photo|

    	json.(photo, :id, :img_url)
    end
    
    json.tools @project.tools do |tool|
    	json.id tool.id
    	json.name tool.technology.name
    end

    json.user do 
    	 json.(@project.user, :name, :image, :slug)

    end

end