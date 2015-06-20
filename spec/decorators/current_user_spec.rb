require "rails_helper"

RSpec.describe CurrentUser do
  it "has a dynamic login/logout button based on the status of the current user" do
    user = User.create!
    unauthenticated = CurrentUser.new(nil)
    authenticated = CurrentUser.new(user)
    login_url = "<a data-method=\"get\" href=\"/auth/github\">Login with Github</a>"
    logout_url = "<a rel=\"nofollow\" data-method=\"delete\" href=\"/logout\">Logout</a>"

    expect(unauthenticated.session_url).to eq(login_url)
    expect(authenticated.session_url).to eq(logout_url)
  end
end
