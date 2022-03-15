json.array! @results do |result|
	json.type result.class.name
	json.object result
	

	if result.user 
		json.owner  result.user
	end

	json.id SecureRandom.hex(5)


end