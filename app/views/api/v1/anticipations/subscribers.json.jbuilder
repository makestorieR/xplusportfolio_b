json.array! @subscribers do |subscriber| 

	json.(subscriber, :slug, :image, :name)

end