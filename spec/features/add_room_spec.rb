require "rails_helper"

describe "Authenticated User" do
  it "can add a chat room" do
    page.visit root_path
    mock_omniauth_user

    within ".right" do
      click_on "Login with GitHub"
    end
    click_link_or_button "Create a new room"

    page.within("#new-room-form") do
      expect(page).to have_content("Room name:")
    end

    fill_in("room[name]", with: "Testing Suite")
    click_on "Create room"

    page.within("#room-show") do
      expect(page).to have_content("Testing Suite")
    end
  end
end

describe "Unauthenticated User" do
  it "does not have the option to create a new room" do
    page.visit root_path
    expect(page).not_to have_content("Create a new room")
  end
end
