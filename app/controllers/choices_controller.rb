class ChoicesController < ApplicationController
  def update
    room = Room.find_by(slug: params[:room_slug])
    choice = room.choices.find(params[:room][:choices])
    choice.update_attributes(chosen: true)
    redirect_to room_path(room)
  end
end
