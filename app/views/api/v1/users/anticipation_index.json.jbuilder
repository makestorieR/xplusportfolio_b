json.array! @anticipations do |anticipation|
    json.id anticipation.id
    json.body anticipation.body 
    json.total_likes anticipation.get_likes.size
    json.cover anticipation.anticipation_cover
end