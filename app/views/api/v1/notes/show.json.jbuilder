json.note do 

	json.(@note, :id, :content, :created_at, :seen)

	json.user do 
		json.(@note.user, :image, :name, :slug)
	end

end