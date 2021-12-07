
json.array! @users do |user|
    json.(user, :name)
end