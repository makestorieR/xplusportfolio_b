json.array! @suggestions do |suggestion|
    json.id suggestion.id
    json.content suggestion.content

    json.user do 
        json.(suggestion.user, :name)
    end
end