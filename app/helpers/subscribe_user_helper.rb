module SubscribeUserHelper
    def subsribe_user(anticipation)

        user = anticipation.user 
        user.followers.each do |user| 
            user.follow anticipation
        end

    end
end
