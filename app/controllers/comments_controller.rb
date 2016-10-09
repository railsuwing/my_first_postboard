class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:content))
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    else

      flash[:error] = "at least 2 words for comment"#render 'posts/show'
      redirect_to post_path(@post)
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:success] = "your vote was counted!"
    else
      flash[:error] = "you have voted"
    end
    
    redirect_to :back
  end
end