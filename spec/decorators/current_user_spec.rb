require "rails_helper"

RSpec.describe CurrentUser do
  it "has a dynamic login/logout button based on the status of the current user" do
    user = User.create!
    unauthenticated = CurrentUser.new(nil)
    authenticated = CurrentUser.new(user)
    login_url = "<a data-method=\"get\" href=\"/auth/github\">Login with GitHub</a>"
    logout_url = "<a rel=\"nofollow\" data-method=\"delete\" href=\"/logout\">Logout</a>"

    expect(unauthenticated.session_url).to eq(login_url)
    expect(authenticated.session_url).to eq(logout_url)
  end

  it "has a created room link which will not appear when the user is nil" do
    user = User.create!
    unauthenticated = CurrentUser.new(nil)
    authenticated = CurrentUser.new(user)
    create_url = "<a href=\"/rooms/new\">Create New Room</a>"
    no_create_url = ""

    expect(unauthenticated.create_room_url).to eq(no_create_url)
    expect(authenticated.create_room_url).to eq(create_url)
  end
end
