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

  it "shows a closed button if the user matches the room's user" do
    creator         = User.create!
    user            = User.create!
    room_creator    = CurrentUser.new(creator)
    regular_user    = CurrentUser.new(user)

    closed = creator.rooms.new(name: "Already closed", state: "closed")
    closed.choices.build(title: "Factory Girl")
    closed.save

    close_button = "<form class=\"button_to\" method=\"post\" action=\"/rooms/#{closed.slug}\"><input type=\"hidden\" name=\"_method\" value=\"put\" /><input class=\"btn col s12\" type=\"submit\" value=\"Close this Topic\" /></form>"
    lack_of_close_button = nil

    expect(regular_user.close_topic(closed)).to eq(lack_of_close_button)
    expect(room_creator.close_topic(closed)).to eq(close_button)
  end
end
