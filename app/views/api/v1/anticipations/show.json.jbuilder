json.anticipation do 
    json.body @anticipation.body 
    json.total_likes @anticipation.get_likes.size
    json.total_suscribers @anticipation.followers.size

    json.suscribers @suscribers do |suscriber|
        json.(suscriber, :name)
    end
end