class DirectMessagesController < ApplicationController
  def create
  	@direct_message = DirectMessage.new(direct_message_params)
  	@direct_message.user_id = current_user.id
  	if @direct_message.save
  	  redirect_to room_path(@direct_message.room)
  	else
  	  redirect_back(fallback_location: root_path)
  	end
  end

  private
  def direct_message_params
  	params.require(:direct_message).permit(:room_id, :message)
  end
end