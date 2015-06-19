class Choice < ActiveRecord::Base
  belongs_to :room
  validates :title, presence: true, allow_blank: false

  def chosen_display
    if chosen?
      "green-text text-lighten-1 bold"
    else
      "red-text text-lighten-4 strikethrough"
    end
  end
end
