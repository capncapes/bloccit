module SessionsHelper
    def create_session(user)
        session[:user_id] = user.id
    end
    
    def gravatar_url(user, size)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end
    
    def destroy_session(user)
        session[:user_id] = nil
    end
    
    def current_user
        User.find_by(id: session[:user_id])
    end
end
