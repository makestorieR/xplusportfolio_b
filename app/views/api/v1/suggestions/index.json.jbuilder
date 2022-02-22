json.array! @suggestions do |suggestion|
    json.(suggestion, :id, :content, :done, :created_at)

end