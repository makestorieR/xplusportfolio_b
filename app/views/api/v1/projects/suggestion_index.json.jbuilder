json.array! @suggestions do |suggestion|
    json.(suggestion, :id, :content, :done, :created_at)

    json.project_slug suggestion.project.slug
    json.user do 
    	 json.(suggestion.user, :name, :image, :slug)

    end
end