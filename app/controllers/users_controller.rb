class UsersController < ApplicationController
  def show
	  @user = User.find(params[:id])
    if params[:country].blank?
      @posts = @user.posts
    else
      @posts = @user.posts.where(country: params[:country])
    end

  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])

    # hennkou
    data = user_params
    data[:sex] = data[:sex].to_i

  	if @user.update(data)
  	  redirect_to user_path(@user.id), notice: "変更されました"
  	else
  	  render "edit"
  	end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following_user
    render 'show_following'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
    render 'show_follower'
  end

  private
  def user_params
  	params.require(:user).permit(:user_name, :account_name, :website, :introduction, :image, :phone_number, :sex)
  end
end
