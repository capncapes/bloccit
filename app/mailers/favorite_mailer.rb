class FavoriteMailer < ApplicationMailer
    default from: "brandoncaples@gmail.com"
    
    def new_comment(user, post, comment)
        
        headers["Message-ID"] = "<comments/#{comment.id}@bloccit-caples.c9users.io>"
        headers["In-Reply-To"] = "<post/#{post.id}@bloccit-caples.c9users.io>"
        headers["References"] = "<post/#{post.id}@bloccit-caples.c9users.io>"
        
        @user = user
        @post = post
        @comment = comment
        
        mail(to: user.email, subject: "New comment on #{post.title}")
    end
    
    def new_post(post)
        
        headers["Message-ID"] = "<comments/#{post.id}@bloccit-caples.c9users.io>"
        headers["In-Reply-To"] = "<post/#{post.id}@bloccit-caples.c9users.io>"
        headers["References"] = "<post/#{post.id}@bloccit-caples.c9users.io>"
        
        @post = post
        
        mail(to: post.user.email, subject: "You are now following #{post.title}")
    end
end
