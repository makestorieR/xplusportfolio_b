json.array! @projects do |project|

	json.(project, :title, :slug, :github_link, :live_link)
    json.total_likes project.get_likes.size
    json.total_votes project.get_upvotes.size
    json.liked project.get_likes.where(voter_id: current_api_v1_user).exists?
    json.voted project.get_upvotes.where(voter_id: current_api_v1_user).exists?
  	json.photo project.project_photos.first.img_url
  	json.user_slug project.user.slug
    

end