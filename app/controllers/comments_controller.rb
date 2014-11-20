class CommentsController < ApplicationController
  respond_to :html, :js

def create
  #@topic = Topic.find(params[:topic_id])
  @post = Post.find(params[:post_id])
  @comment = current_user.comments.build(comment_params)
  @comment.post = @post
  if @comment.save
    flash[:notice] = "Comment was saved."
  else
    flash[:error] = "There was an error saving the comment."
  end
  redirect_to [@post.topic, @post]
end

def destroy
  #@topic = Topic.find(params[:topic_id])
  @post = Post.find(params[:post_id])
  @comment = @post.comments.find(params[:id])

  authorize @comment
  if @comment.destroy
    flash[:notice] = "Comment was removed."
  else
    flash[:error]  = "Comment couldn't be deleted. Try again."
  end

  respond_with(@comment) do |format|
    format.html { redirect_to [@post.topic, @post] }
  end
end


private
 
 def comment_params
  params.require(:comment).permit(:body, :post_id)
end
end
