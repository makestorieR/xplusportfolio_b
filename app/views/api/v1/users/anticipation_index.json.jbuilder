json.array! @anticipations do |anticipation|
    json.id anticipation.id
    json.body anticipation.body 
    
    json.cover anticipation.anticipation_cover
    json.created_at anticipation.created_at
    json.due_date anticipation.due_date
    json.expired Time.now > anticipation.due_date 
    json.fulfilled !anticipation.project.nil?
    json.total_subscribers anticipation.followers_by_type_count('User')
    json.total_likes anticipation.get_likes.size
    json.is_subscribed current_api_v1_user.following?(anticipation)
    json.a_slug anticipation.slug
    json.defaulted (Time.now > anticipation.due_date && anticipation.project.nil?)


    if anticipation.project
    	json.project_slug anticipation.project.slug
    end

    json.liked anticipation.get_likes.where(voter_id: current_api_v1_user).exists?
    
    json.user do 
    	 json.(anticipation.user, :name, :image, :slug)

    end
end