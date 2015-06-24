class RoomsController < ApplicationController
  respond_to :json, :html

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

    if request.xhr?
      respond_with @room
    end
  end

  def update
    room = Room.find_by(slug: params[:slug])
    room.update!(state: "closed")
    choice = room.random_choice
    choice.update!(chosen: true)

    if request.xhr?
      respond_with choice.title
    else
      redirect_to room_path(room)
    end

  end

  def catch_animation
    room = Room.find_by(slug: params[:slug])
    room.update!(rate: params[:time_left])
    head :ok
  end

  def send_animation
    room = Room.find_by(slug: params[:slug])
    respond_with room.rate.to_json, json: room.rate.to_json
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
