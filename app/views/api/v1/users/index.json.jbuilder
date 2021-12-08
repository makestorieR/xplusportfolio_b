
json.array! @users do |user|
    
    next if user.id == current_api_v1_user.id
    json.id json.id
    json.name user.name
    
end
