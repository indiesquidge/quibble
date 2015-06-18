require "rails_helper"

describe "Room status" do
  it "appears as pending while inactive and not completed" do
    page.visit new_room_path

    fill_in("room[name]", with: "Status test")
    click_on "Create room"

    visit root_path

    page.within(".rooms") do
      expect(page).to have_content("Pending")
      expect(page).not_to have_content("Active")
      expect(page).not_to have_content("Closed")
    end
  end

  it "changes to active when a user enters the room" do
    room = Room.create!(name: "Mocking Library")
    page.visit room_path(room)

    page.within("#room-show") do
      expect(page).to have_content("Active")
    end
  end
end
