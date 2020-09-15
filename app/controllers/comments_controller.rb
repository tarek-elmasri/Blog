class CommentsController < ApplicationController
    before_action :authenticate_user! 
    before_action :have_access! ,only: [:destroy]



    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create (comment_params)
        @comment.user_id= current_user.id
        if (@comment.save)
            redirect_to @post , notice: "Comment posted successfully"
        else
            redirect_to  post_path(@post) , alert: "Error creating comment, Comment must have minimum 2 charc"
        end 

    end 

    def destroy 
        @comment = Comment.find(params[:id])
        if (@comment.delete)
            redirect_to post_path(@comment.post) , notice: "Comment deleted successfully"
        else 
            redirect_to  post_path(@comment.post) , alert: "Error deleting comment"
        end 

    end 











    private

    def comment_params
        params.require(:comment).permit(:comment)
    end 

    def have_access!
        @comment = Comment.find(params[:id])
        @post= Post.find(params[:post_id])
        unless current_user.admin? || @comment.user_id == current_user.id
            redirect_to @post, alert: "Un Authurized Action"
        end 
    end 

end
