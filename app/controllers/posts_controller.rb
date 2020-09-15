class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:show , :index ]
    before_action :have_access! , only: [ :edit, :destroy , :update ]


    def index 
        @posts = Post.all
    end 


    def new 
        @post = Post.new
    end 

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments.all
        @comment = Comment.new
    end 

    def create 
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if (@post.save)
            redirect_to @post , notice: "Posted Succesfully"
        else
            render 'new' 
        end 
    end 


    def edit 
        @post = Post.find(params[:id])
    end 

    def destroy 
        @post = Post.find(params[:id])

        #deleting article comments before killing it
        if @post.comments.any?
            @post.comments.each do |comment|
                comment.delete 
            end
        end 

        if (@post.delete)
            flash.notice = "Article deleted successfully"
        else
            flash.alert =  "An error happened during deleting"
        end 
        redirect_to posts_path
    end 

    def update 
        @post = Post.find(params[:id])
        if (@post.update(post_params))
            redirect_to post_path(@post), notice: "Article updated successfully"
        else 
            render 'edit' 
        end 
    end 


    private
    def have_access!
        @post = Post.find(params[:id])
        unless current_user.id == @post.user.id || current_user.admin?
            redirect_to posts_path , alert: "Un Authorized Action"
        end 
    end 

    def post_params
        params.require(:post).permit(:title , :body)
    end 


end
