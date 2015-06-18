require "rails_helper"

describe "Room status" do
  it "appears as pending immediately after a room has been created" do
    page.visit new_room_path

    fill_in("room[name]", with: "Status test")
    click_on "Create room"

    page.within("#room-show") do
      expect(page).to have_content("Pending")
    end
  end
end
