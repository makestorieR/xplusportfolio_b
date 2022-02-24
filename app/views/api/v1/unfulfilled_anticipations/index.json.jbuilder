json.array! @anticipations do |anticipation|
    json.id anticipation.id
    json.body anticipation.body 
    
    
    json.a_slug anticipation.slug

    json.cover anticipation.anticipation_cover
    json.created_at anticipation.created_at
    json.due_date anticipation.due_date

    
end