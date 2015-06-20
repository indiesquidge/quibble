RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end

def mock_omniauth_user
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
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
end
