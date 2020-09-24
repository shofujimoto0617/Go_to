class PostsController < ApplicationController
  before_action :authenticate_user!
  def new
  	@post = Post.new
  	# postクラスに関連づいたpost_imageクラスのインスタンス
  	@post.post_images.build
  end

  def index
    search = params[:search]
    if search.blank?
      @tags = Tag.all
    else
      @tags = Tag.search(search)
    end

    if params[:tag_search]
      tag = Tag.find(params[:tag_search])
      @posts = tag.posts
    else
  	  @posts = Post.all
    end
  end

  def show
  	@post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
    tag_list = params[:post][:tag_ids].split(',')
  	if @post.save
      @post.save_tags(tag_list)
  	  redirect_to posts_path, notice: "Completed !!"
    else
      render 'new'
    end
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
  	if @post.update(post_params)
  	  redirect_to post_path(@post.id), notice: "Completed !!"
    else
      render 'edit'
    end
  end

  def destroy
  	@post = Post.find(params[:id])
    for tag in @post.tags
    tag_count = TagMap.where(tag_id: tag.id).distinct.count

      if tag_count <= 1
        tag.destroy
      end
    end
    @post.destroy
  	redirect_to posts_path
  end

  private
  def post_params
  	params.require(:post).permit(:country, :place, :body, :start_date, :finish_date, :price, post_images_images: [])
  end

end
