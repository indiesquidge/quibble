class MessagesController < ApplicationController
  def create
    room = Room.find_by(id: params[:room_id])
    message = Message.new(message_params)
    if message.save
      room.messages << message
      flash[:success] = "Your message has sent!"
    else
      flash[:error] = "An error prevented your message from sending."
    end
    redirect_to :back
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
