class User < ActiveRecord::Base
  has_many :messages, inverse_of: :user
end
