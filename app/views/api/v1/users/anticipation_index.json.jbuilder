json.array! @anticipations do |anticipation|
    json.id anticipation.id
    json.body anticipation.body 
    json.total_likes anticipation.get_likes.size
    json.cover anticipation.anticipation_cover
    json.created_at anticipation.created_at
    json.due_date anticipation.due_date
   
    json.total_subscribers anticipation.followers_count

    
    json.user do 
    	 json.(anticipation.user, :name, :image, :slug)

    end
end