require "rails_helper"

RSpec.describe CurrentUser do
  include Draper::ViewHelpers
  it "has a dynamic login/logout button based on the status of the current user" do
    user            = User.create!
    unauthenticated = CurrentUser.new(nil)
    authenticated   = CurrentUser.new(user)

    login_url  = "<a data-method=\"get\" href=\"/auth/github\">Login with GitHub</a>"
    logout_url = "<a rel=\"nofollow\" data-method=\"delete\" href=\"/logout\">Logout</a>"

    expect(unauthenticated.session_url).to eq(login_url)
    expect(authenticated.session_url).to eq(logout_url)
  end

  it "has a created room link which will not appear when the user is nil" do
    user            = User.create!
    unauthenticated = CurrentUser.new(nil)
    authenticated   = CurrentUser.new(user)

    create_url    = "<a href=\"/rooms/new\">Create New Room</a>"
    no_create_url = ""

    expect(unauthenticated.create_room_url).to eq(no_create_url)
    expect(authenticated.create_room_url).to eq(create_url)
  end

  it "creates a form submit button or link to login if user is nil" do
    user            = User.create!
    unauthenticated = CurrentUser.new(nil)
    authenticated   = CurrentUser.new(user)

    h.form_for("test", url: "example.com"){|f| @form = f}

    form_submit = "<input type=\"submit\" name=\"commit\" value=\"Create room\" class=\"btn\" />"
    link_to_login = "<a class=\"btn\" href=\"/auth/github\">Login to create room</a>"

    expect(unauthenticated.form_link(@form)).to eq(link_to_login)
    expect(authenticated.form_link(@form)).to eq(form_submit)
  end

  it "shows a closed button if the user matches the room's user" do
    creator         = User.create!
    user            = User.create!
    room_creator    = CurrentUser.new(creator)
    regular_user    = CurrentUser.new(user)

    closed = creator.rooms.new(name: "Already closed", state: "closed")
    closed.choices.build(title: "Factory Girl")
    closed.save

    close_button = "<form class=\"button_to\" method=\"post\" action=\"/rooms/#{closed.slug}\"><input type=\"hidden\" name=\"_method\" value=\"put\" /><input class=\"btn col s12\" type=\"submit\" value=\"Close this Topic\" /></form>"
    lack_of_close_button = ""

    expect(regular_user.close_topic(closed)).to eq(lack_of_close_button)
    expect(room_creator.close_topic(closed)).to eq(close_button)
  end
end
