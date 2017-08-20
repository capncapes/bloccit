class Post < ApplicationRecord
    has_many :comments
    
    spam_id = 1
    Post.update(spam_id, :title => 'SPAM')
    
    Post.all.each do |post|
        spam_id = post.id if post.id % 5 == 0
        Post.update(spam_id, :title => 'SPAM')
    end
end
