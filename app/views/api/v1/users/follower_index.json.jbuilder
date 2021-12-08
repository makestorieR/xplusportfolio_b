json.array! @followers do |follower|

    json.(follower, :name, :slug)

end