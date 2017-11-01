module UsersHelper
    def user_posts(user)
        count = user.posts.count
        
        if count == 0
            "#{user.name} has not submitted any posts yet."
        else
            "Posts"
        end
    end
    
    def user_comments(user)
        count = user.comments.count
        
        if count == 0
            "#{user.name} has not submitted any comments yet."
        else
            "Comments"
        end
    end
end
