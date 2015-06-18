class RoomsController < ApplicationController
  def new
  end

  def create
    room = Room.new(room_params)
    room.choices.build(title: params[:room][:choice])
    if room.save
      redirect_to room_path(room)
      flash[:success] = "Your room has been created!"
    else
      flash[:error] = "An error prevented your room from being saved."
      redirect_to root_path
    end
  end

  def show
    @room = Room.find_by(slug: params[:slug])
    @messages = @room.messages
  end

  def update
    room = Room.find_by(slug: params[:slug])
    room.update(state: "closed")

    redirect_to :back
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
