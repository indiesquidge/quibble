require "rails_helper"

RSpec.describe CurrentUser do
  include Draper::ViewHelpers
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

  it "creates a form submit button or link to login if user is nil" do
    user = User.create!
    unauthenticated = CurrentUser.new(nil)
    authenticated = CurrentUser.new(user)

    h.form_for("test", url: "example.com"){|f| @form = f}

    form_submit = "<input type=\"submit\" name=\"commit\" value=\"Create room\" class=\"btn\" />"
    link_to_login = "<a class=\"btn\" href=\"/auth/github\">Login to create room</a>"

    expect(unauthenticated.form_link(@form)).to eq(link_to_login)
    expect(authenticated.form_link(@form)).to eq(form_submit)
  end
end
