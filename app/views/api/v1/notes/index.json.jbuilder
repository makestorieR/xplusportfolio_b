json.array! @notes do |note|
	
	json.(note, :id, :content)
	json.user do
		json.(note.user, :image, :name)
	end

end