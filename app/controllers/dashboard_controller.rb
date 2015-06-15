class DashboardController < ApplicationController
  def index
    @rooms = Room.all
  end
end
