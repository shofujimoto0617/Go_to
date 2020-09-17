class UsersController < ApplicationController
  def show
	  @user = User.find(params[:id])
    @posts = @user.posts

    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def show_country
    @user = User.find(params[:id])
    # linkから受け取る値(all/0/1)で条件分岐
    if params[:country] == "all"
      @posts = @user.posts
    else
      @posts = @user.posts.where(country: params[:country])
    end
  end

  def edit
  	@user = User.find(params[:id])
    # ラジオボタンにチェックしていればtrue/チェックなければfalse
    @man = @user.sex == "男性" ? true : false
    @femalu = @user.sex == "女性" ? true : false
  end

  def update
  	@user = User.find(params[:id])
    # date型に変換
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
