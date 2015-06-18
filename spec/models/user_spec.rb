require "rails_helper"

RSpec.describe User do
  it "creates its attributes from omniauth's response" do
    data = OmniAuth::AuthHash.new({
      "provider" => "github",
      "uid"      => "123456",
      "info" => {
        "email"    => "email@example.com",
        "nickname" => "mock_user",
        "image"    => "mock_user_thumbnail_url"
      },
      "credentials" => {
        "token"  => "mock_token"
      }
    })

    user = User.find_or_create_from_auth(data)
    expect(user).to be_valid
  end
end
