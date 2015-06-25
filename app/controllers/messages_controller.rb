require_relative "../../lib/redis_config"

class MessagesController < ApplicationController
  respond_to :json

  def index
    $room = Room.find_by(slug: params[:slug])
    respond_with Message.where(room_slug: $room.slug)
  end

  def create
    message = Message.create(body: params[:message][:body],
                             room_slug: $room.slug)

    respond_with message

    $redis.publish "channel", message.to_json
  end
end
