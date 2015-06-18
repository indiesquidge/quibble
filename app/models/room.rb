class Room < ActiveRecord::Base
  after_create :slug_it_up
  has_many :messages, inverse_of: :room
  has_many :choices
  validates_presence_of :name, :choices
  belongs_to :user, inverse_of: :rooms

  enum state: %w(pending active closed)

  def to_param
    slug
  end

  def slug_it_up
    update!(slug: name.parameterize)
  end

  def display_state
    state.capitalize
  end

  def display_current_state
    if state == "pending"
      "Active"
    else
      display_state
    end
  end
end
