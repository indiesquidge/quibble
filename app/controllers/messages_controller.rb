class MessagesController < ApplicationController
  def create
    message = Room.find_by(id: params[:room_id]).messages.new(message_params)
    if message.save
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
