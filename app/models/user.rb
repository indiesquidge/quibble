class User < ActiveRecord::Base
  has_many :messages, inverse_of: :user
  has_many :rooms, inverse_of: :user

  def self.find_or_create_from_auth(data)
    user = User.find_or_create_by(provider: data.provider, uid: data.uid)

    user.name      = data.info.nickname
    user.email     = data.info.email
    user.image_url = data.info.image
    user.token     = data.credentials.token
    user.save

    user
  end
end
