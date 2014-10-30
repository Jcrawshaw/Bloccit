class CommentsController < ApplicationController


def create
  @topic = Topic.find(params[:topic_id])
  @post = @topic.posts.find(params[:post_id])
  @comment = current_user.comments.build(comment_params)
  @comment.post = @post
  if @comment.save
    flash[:notice] = "Comment was saved."
  else
    flash[:error] = "There was an error saving the comment."
  end
  #@comments = @post.comments

  # @comment = current_user.comments.build(comment_params)
  # @comment.post = @post
  # @new_comment = Comment.new
  redirect_to [@topic, @post]
end

def destroy
  @topic = Topic.find(params[:topic_id])
  @post = @topic.posts.find(params[:post_id])
  @comment = @post.comments.find(params[:id])

  authorize @comment
  if @comment.destroy
    flash[:notice] = "Comment was removed."
    redirect_to [@topic, @post]
  else
    flash[:error]  = "Comment couldn't be deleted. Try again."
    redirect_to [@topic, @post]
  end
end


private
 
 def comment_params
  params.require(:comment).permit(:body, :post_id)
end
end
