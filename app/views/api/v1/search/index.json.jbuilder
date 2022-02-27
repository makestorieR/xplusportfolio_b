json.array! @results do |result|
	json.type result.class.name
	json.object result.object
	json.id SecureRandom.hex(5)


end