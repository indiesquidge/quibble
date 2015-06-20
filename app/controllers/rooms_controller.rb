class RoomsController < ApplicationController
  respond_to :json, :html

  def new
  end

  def create
    room = Room.new(room_params)
    params[:room][:choices].each { |choice| room.choices.build(title: choice) }
    if room.save
      room.update!(user_id: current_user.id)
      respond_with room
    else
      head :bad_request
    end
  end

  def show
    @room = Room.find_by(slug: params[:slug])
    @messages = @room.messages
  end

  def update
    room = Room.find_by(slug: params[:slug])
    room.update!(state: "closed")
    room.random_choice.update!(chosen: true)

    if request.xhr?
      respond_with room.state, json: room.state
    else
      redirect_to room_path(room)
    end

  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
