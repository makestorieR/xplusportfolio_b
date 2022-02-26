json.array! @notifications do |notification|

    json.type notification.type 
    json.read notification.read?
    json.object notification.params
    
    json.user_slug notification.params[:anticipation].user.slug if notification.params[:anticipation]

end