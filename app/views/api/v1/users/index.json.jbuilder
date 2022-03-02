
json.array! @users.order(created_at: :desc) do |user|
    
    next if user.id == current_api_v1_user.id
    json.slug user.slug
    json.name user.name
    json.total_projects user.projects.size
    json.total_anticipations user.anticipations.size
    json.repu_coin user.repu_coin
    json.is_following current_api_v1_user.following?(user)
    
    
end
