class Admin < ApplicationRecord
    belongs_to :user


    def classify (option)
        case option[:search_by] 
        when 'user'
            if option.has_key?(:user)
                value = option['user']
                if User.where(username: value).exists?
                    @user= User.find_by(username: value) 
                    #redirect after success
                    result = [ @user , true , "Found match"]
                    return result
                else
                    #:render_error( "Username not found, please try again")
                    result = [ "" ,  false,  "Username not found"]
                    return result
                end 
            end  
        
        when 'email'
            if option.has_key?(:email)
                value = option['email']
                if User.where(email: value).exists?
                    @user= User.find_by(email: value) 
                    #redirect after success
                    result = [ @user , true , "Found match"]
                    return result
                else
                    #:render_error( "email not found, please try again")
                    result = [ "" ,  false,  "E-mail not found"]
                    return result
                end 
            end  
        
        when 'article'
            if option.has_key?(:article)
                value = option['article']
                if Post.where(title: value).exists?
                    @post = Post.find_by(title: value)
                    @user= @post.user
                    #redirect after success
                    result = [ @user , true , "Found match"]
                    return result
                else
                    #:render_error( "Username not found, please try again")
                    result = [ "" ,  false,  "Article not found"]
                    return result
                end 
            end  
        
        when 'all'
            @user= User.all
            #redirect after success
            result = [ @user , "all" , "All users"]
            return result
        end 
    end


end
