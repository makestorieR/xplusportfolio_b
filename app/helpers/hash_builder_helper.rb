module HashBuilderHelper

	def get_activity_hash(activity)

		anticipation = activity.trackable

		{

			id: SecureRandom.hex(5),
			action_type: activity.key,
			owner_name: activity.owner.name,
			owner_slug: activity.owner.slug,
			created_at: activity.created_at,
			activity: {
			    id: anticipation.id,
			    body: anticipation.body,
			    cover: anticipation.anticipation_cover,
			    created_at: anticipation.created_at,
			    due_date: anticipation.due_date,
			    expired: Time.now > anticipation.due_date,
			    fulfilled: !anticipation.project.nil?,
			    total_subscribers: anticipation.followers_by_type_count('User'),
			    total_likes: anticipation.get_likes.size,
			    is_subscribed: true,
			    a_slug: anticipation.slug,
			    defaulted: (Time.now > anticipation.due_date && anticipation.project.nil?),
			    project_slug: anticipation.project ? anticipation.project.slug : nil,
			    liked: false,
			    user: {
			    	name: anticipation.user.name,
			    	image: anticipation.user.image,
			    	slug: anticipation.user.slug,
			    }
			
			}

		}


	end
end
