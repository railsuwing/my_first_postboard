class PostsController < ApplicationController
  def index
    @posts = Post.all.sort_by {|x| x.total_votes }.reverse
  end
  
  def show
  	 #Rails 會把用戶所有傳進來的參數打包成一個叫 params 的 Hash
    #find 代表搜尋某一比資料，而 params[:id] 代表用戶想查詢的資料 id
 		@post = Post.find(params[:id])
 		@comment = Comment.new
  	@comments = @post.comments
  end

  def new
  	#產出一個空白物件(一筆空白資料)，並顯示在 posts/new 頁面
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user = current_user
     #如果成功存進資料庫，就導回 index 頁面，失敗就再顯示一次表單
    if post.save!
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def vote
    @post = Post.find(params[:id])
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:success] = 'Your vote was counted!'
    else
      flash[:error] = "You can only vote for #{@post.title} once!"
    end

    redirect_to :back
  end

  private
#確保 params 裡面的 post hash 存在，並且允許 title 和 content 被存取
  def post_params
    params.require(:post).permit(:title, :content, category_ids: [])
  end
end