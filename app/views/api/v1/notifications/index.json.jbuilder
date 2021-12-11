json.array! @notifications do |notification|

    json.type notification.type 
    json.read notification.read?
    json.object notification.params

end