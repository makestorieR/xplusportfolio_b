module SubscribeUserHelper
    def subscribe_user(anticipation)

        user = anticipation.user 
        user.followers.each do |user| 
            user.follow anticipation
        end

    end
end
