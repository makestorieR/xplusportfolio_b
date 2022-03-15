json.array! @suggestions do |suggestion|
    json.(suggestion, :id, :content, :done, :image_url, :created_at)

   
    json.user do 
    	 json.(suggestion.user, :name, :image, :slug)

    end
end