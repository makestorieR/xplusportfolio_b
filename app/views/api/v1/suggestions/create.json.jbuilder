json.suggestion do 
    
    json.(@suggestion, :id, :created_at, :content, :done)
    
    json.project_slug @suggestion.project_slug

    json.user do 
    	 json.(@suggestion.user, :name, :image, :slug)

    end

end