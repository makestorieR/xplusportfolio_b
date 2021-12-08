json.array! @projects do |project|
    
    json.title project.title 
    json.description project.description
    json.total_likes project.get_likes.size
    json.total_votes project.get_upvotes.size
    json.slug project.slug
end
