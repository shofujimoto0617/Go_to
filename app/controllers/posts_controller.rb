class PostsController < ApplicationController
  def new
  	@post = Post.new
  	# postクラスに関連づいたpost_imageクラスのインスタンス
  	@post.post_images.build
  end

  def index
  	@posts = Post.all
    @user = User.find(current_user.id)
  end

  def show
  	@post = Post.find(params[:id])
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	# start_dateをdate型に変換
  	@post.start_date = params[:start_date].to_date
  	# finish_dateをdate型に変換
  	@post.finish_date = params[:finish_date].to_date
  	@post.save
  	redirect_to posts_path
  end

  def edit
  	@post = Post.find(params[:id])
  	if current_user != @post.user
  	  redirect_to posts_path
  	end
  end

  def update
  	@post = Post.find(params[:id])
  	# start_dateの値　代入
  	@post.start_date = params[:start_date]
  	# finish_dateの値　代入
  	@post.finish_date = params[:finish_date]
  	@post.update(post_params)
  	redirect_to post_path(@post.id)
  end

  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
  	redirect_to posts_path
  end

  private
  def post_params
  	params.require(:post).permit(:country, :place, :body, :start_date, :finish_date, :price, post_images_images: [])
  end
end
