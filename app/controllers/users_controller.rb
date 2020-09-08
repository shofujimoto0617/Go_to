class UsersController < ApplicationController
  def show
	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	  redirect_to user_path(@user.id), notice: "変更されました"
  	else
  	  render "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:user_name, :account_name, :website, :introduction, :image)
  end
end
