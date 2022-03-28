json.array! @resources do |resource|

	json.(resource, :id, :img_url, :title, :desc, :link, :color, :video_url)

end