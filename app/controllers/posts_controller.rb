class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def show
  	 #Rails 會把用戶所有傳進來的參數打包成一個叫 params 的 Hash
    #find 代表搜尋某一比資料，而 params[:id] 代表用戶想查詢的資料 id
 		@post = Post.find(params[:id])
 		@comment = Comment.new
  	@comments = @post.comments
  end
end