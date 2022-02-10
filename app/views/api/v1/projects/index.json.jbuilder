json.array! @projects do |project|
    
   	json.(project, :title, :slug, :github_link, :live_link, :created_at)
    json.total_likes project.get_likes.size
    json.total_votes project.get_upvotes.size

    json.liked project.get_likes.where(voter_id: current_api_v1_user).exists?


    json.project_photos project.project_photos do |photo|

    	json.(photo, :id, :img_url)
    end
    
    json.user do 
    	 json.(project.user, :name, :image, :slug)

    end

end
