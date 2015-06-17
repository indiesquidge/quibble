class Room < ActiveRecord::Base
  after_create :slug_it_up
  has_many :messages, inverse_of: :room
  has_many :choices
  validates_presence_of :name, :choices

  def to_param
    slug
  end

  def slug_it_up
    update!(slug: name.parameterize)
  end
end
