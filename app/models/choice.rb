class Choice < ActiveRecord::Base
  belongs_to :room

  def chosen_display
    if chosen?
      "green lighten-1 bold"
    else
      "red lighten-4 strikethrough"
    end
  end
end
