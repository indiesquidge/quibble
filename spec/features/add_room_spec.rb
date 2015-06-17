require "rails_helper"

describe "Authenticated User" do
  it "can add a chat room" do
    page.visit root_path
    mock_omniauth_user

    within ".right" do
      click_on "Login with GitHub"
    end

    fill_in("room[name]", with: "Testing Suite")
    click_on "Create room"

    page.within("#room-show") do
      expect(page).to have_content("Testing Suite")
    end
  end
end

describe "Unauthenticated User" do
  it "must login before creating a new room" do
    page.visit root_path
    expect(page).to have_content("Login to create room")
    fill_in("room[name]", with: "testing")
    click_on("Login to create room")
    expect(page).to have_content("Create New Room")
  end
end
