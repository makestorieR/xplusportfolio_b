json.array! @suggestions do |suggestion|
   
    json.(suggestion, :id, :content, :done, :image_url, :created_at)

    json.project_slug suggestion.project.slug
    json.project_title suggestion.project.title
end
