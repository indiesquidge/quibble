class Choice < ActiveRecord::Base
  belongs_to :room
  validates :title, presence: true, allow_blank: false
end
