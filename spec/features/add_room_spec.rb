require 'rails_helper'

describe "Authenticated User" do
  it "can add a chat room" do
    page.visit root_path
#user = mock_omniauth_user

  #click_on "Login with GitHub"
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
