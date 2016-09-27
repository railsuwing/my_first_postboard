class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def show
 		@post = Post.find(params[:id])
 		@comment = Comment.new
  	@comments = @post.comments
  end
end