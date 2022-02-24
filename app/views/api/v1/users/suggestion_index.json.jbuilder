json.array! @suggestions do |suggestion|
   
    json.total_likes suggestion.get_likes.size


    json.(suggestion, :id, :content, :done, :created_at)

    json.project_slug suggestion.project.slug
    json.project_title suggestion.project.title
end