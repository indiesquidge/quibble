require_relative "../../lib/redis_config"

class MessagesController < ApplicationController
  respond_to :json

  def index
    # room = Room.find_by(slug: params[:slug])
    # respond_with Message.where(room_id: room.id)
    respond_with Message.all
  end

  def create
    message = Message.create(body: params[:message][:body],
                             room_id: params[:message][:room_id])
    room = message.room

    respond_with message
    $redis.publish room.slug, message.to_json
  end
end
