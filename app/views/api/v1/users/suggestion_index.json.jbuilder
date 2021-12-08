json.array! @suggestions do |suggestion|
    json.id suggestion.id
    json.content suggestion.content 
    json.total_likes suggestion.get_likes.size
    json.done suggestion.done
end