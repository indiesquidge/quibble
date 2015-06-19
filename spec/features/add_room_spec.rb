require "rails_helper"

describe "Authenticated User" do
  it "can add a chat room", js: true do
    page.visit root_path
    mock_omniauth_user
    click_link_or_button "Login to create room"

    within "#new-room-form" do
      page.fill_in("topic-field", with: "Testing Suite")
      page.fill_in("choice-field", with: "rspec")
      page.click_link_or_button "Create Room"
    end

    page.within("#room-show") do
      expect(page).to have_content("Testing Suite")
    end
  end

  it "clicks a button to add additional choice input fields", js: true do
    page.visit root_path
    mock_omniauth_user
    click_link_or_button "Login to create room"

    within "#new-room-form" do
      page.fill_in("topic-field", with: "Testing Suite")
      page.fill_in("choice-field", with: "rspec")
      find(:css, "#add-input-field").click
      input_count = all(".choice-field").count
      expect(input_count).to eq(2)
    end

  end
end

describe "Unauthenticated User" do
  it "must login before creating a new room", js: true do
    page.visit root_path

    expect(page).to have_content("LOGIN TO CREATE ROOM")

    click_link_or_button "Login to create room"
    fill_in("topic-field", with: "Testing Suite")
    fill_in("choice-field", with: "rspec")
    click_on("Create Room")

    expect(page).to have_content("Testing Suite")
  end
end
