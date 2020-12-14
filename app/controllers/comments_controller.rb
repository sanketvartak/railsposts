class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update, :destroy]
  
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        redirect_to post_path(@post)
    end
    private def comment_params
        params.require(:comment).permit(:username, :body, :user_id)
    end
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
      end

      def correct_user
        @user = current_user.Comments.find_by(id: params[:id])
        redirect_to post_index_path, notice: "Not authorized to edit this post" if @user.nil?
      end
end
