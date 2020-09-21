class RoomsController < ApplicationController
  def create
  	@room = Room.create
  	current_entry = Entry.create(user_id: current_user.id, room_id: @room.id)
  	another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: @room.id)
  	redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
  	if Entry.where(user_id: current_user.id, room_id: @room.id)
  	  @direct_messages = @room.direct_messages
  	  @direct_message = DirectMessage.new

   	  @another_user = @room.entries.where.not(user_id: current_user.id).first.user
  	else
  	  redirect_back(fallback_location: posts_path)
  	end
  end

  def index
    @entries = Entry.where.not(user_id: current_user.id)
  end

end
