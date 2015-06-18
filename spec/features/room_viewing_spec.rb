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

  it "has a button for room creator to change status to closed" do
    page.visit root_path
    user = mock_omniauth_user

    page.within("#github-login .right") do
      page.click_on "Login with GitHub"
    end

    page.visit new_room_path

    fill_in("room[name]", with: "Code Review Criteria")
    click_on "Create room"

    page.within("#room-show") do
      expect(page).to have_content("Active")
    end

    expect(page).to have_button("Close this Topic")
    click_on "Close this Topic"

    page.within("#room-show") do
      expect(page).to have_content("Closed")
    end
  end
end
