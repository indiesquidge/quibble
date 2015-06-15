require "rails_helper"

RSpec.describe "User on root path", type: :feature do
  it "sees a list of available chatrooms" do
    chatroom1 = Room.create!(name: "room 1")
    chatroom2 = Room.create!(name: "room 2")

    page.visit root_path
    page.within(".rooms") do
      expect(page).to have_link(chatroom1.name)
      expect(page).to have_link(chatroom2.name)
    end
  end
end
