class AdminControlerController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!


    def index
        

    end

    def users 
        @search_id = params[:id]
        unless @search_id == "all"
            @user= User.find(@search_id)
        else 
            @users=User.all 
        end
    end 

    def search_options

        @admin = Admin.new(user_id: current_user.id)
        @option = params[:search]
        
        unless @option.has_key?(:search_by)
            redirect_to  '/admin_controler/index' , alert: "Please choose research type"
        else
            result = @admin.classify(@option)
            @user = result[0]
            find = result[1]
            msg =result[2]

            if find==true
                redirect_to :action => 'users'  , :id => @user.id 
            elsif find=="all"
                redirect_to :action => 'users' , :id => "all"
            else
                redirect_to "/admin_controler/index" , alert: msg
            end 
            
        end 
    end




    private
    def authenticate_admin! 
        unless current_user.admin?
            redirect_to root_path , alert: "Un Authurized Action!"
        end 
    end 

    
end
