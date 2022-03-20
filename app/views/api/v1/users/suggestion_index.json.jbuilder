json.array! @suggestions do |suggestion|
   
    json.(suggestion, :id, :content, :done, :image_url, :created_at)

    json.user do 
    	 json.(suggestion.user, :name, :image, :slug)

    end

    json.project_slug suggestion.project.slug
    json.project_title suggestion.project.title
end
