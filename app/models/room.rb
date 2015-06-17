class Room < ActiveRecord::Base
  after_create :slug_it_up
  has_many :messages, inverse_of: :room

  def to_param
    slug
  end

  def slug_it_up
    update!(slug: name.parameterize)
  end
end
