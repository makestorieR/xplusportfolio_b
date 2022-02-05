json.array! @anticipation_covers do |anticipation_cover|
  
  json.(anticipation_cover, :id, :text_color, :name, :image)
end