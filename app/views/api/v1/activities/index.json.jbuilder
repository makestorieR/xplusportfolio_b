json.array! @activities do |activity|
	 
	json.id activity.id 
	json.action_type activity.key
	json.owner_name activity.owner.name 
	json.owner_slug activity.owner.slug
	
	json.created_at activity.created_at

	if activity.trackable_type === 'Anticipation' 

			json.activity do 

				anticipation = activity.trackable

			    json.id anticipation.id
			    json.body anticipation.body 
			    
			    json.cover anticipation.anticipation_cover
			    json.created_at anticipation.created_at
			    json.due_date anticipation.due_date
			    json.expired Time.now > anticipation.due_date 
			    json.fulfilled !anticipation.project.nil?
			    json.total_subscribers anticipation.followers_by_type_count('User')
			    json.total_likes anticipation.get_likes.size
			    json.is_subscribed current_api_v1_user.following?(anticipation)
			    json.a_slug anticipation.slug
			    json.defaulted (Time.now > anticipation.due_date && anticipation.project.nil?)


			    if anticipation.project
			    	json.project_slug anticipation.project.slug
			    end

			    json.liked anticipation.get_likes.where(voter_id: current_api_v1_user).exists?
			    
			    json.user do 
			    	 json.(anticipation.user, :name, :image, :slug)

			    end

			end

	elsif activity.trackable_type === 'Suggestion'

		json.activity do 

				project = activity.trackable.project



				json.(project, :id, :title, :description, :slug, :github_link, :live_link, :created_at)
    			json.total_likes project.get_likes.size
			    json.total_votes project.get_upvotes.size

			    json.liked project.get_likes.where(voter_id: current_api_v1_user).exists?
			    json.voted project.get_upvotes.where(voter_id: current_api_v1_user).exists?
			    json.total_suggestions project.suggestions.size	





			    json.project_photos project.project_photos do |photo|

			    	json.(photo, :id, :img_url)
			    end
			    
			    json.tools project.tools do |tool|
			    	json.id tool.id
			    	json.name tool.technology.name
			    end

			    json.user do 
			    	 json.(project.user, :name, :image, :slug)

			    end


		end



	end






end
