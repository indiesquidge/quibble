class Choice < ActiveRecord::Base
  belongs_to :room
  validates :title, allow_blank: false
end
