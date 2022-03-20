module SubscribeUserHelper
    def subscribe_user(anticipation)

        user = anticipation.user 
        user.followers_by_type('User').each do |user| 
            user.follow anticipation
            
        end

        user.following_by_type('User').each do |user| 
            user.follow anticipation
        end

    end
end
