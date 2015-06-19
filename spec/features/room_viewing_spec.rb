require "rails_helper"

describe "Room status" do
  it "appears as pending while inactive and not completed" do
    page.visit root_path
    mock_omniauth_user

    page.within("#github-login .right") do
      page.click_on "Login with GitHub"
    end

    fill_in("room[name]", with: "Status test")
    fill_in("room[choice]", with: "first")
    fill_in("room[choice]", with: "second")
    click_on "Create room"

    page.visit root_path

    page.within(".rooms") do
      expect(page).to have_content("Pending")
      expect(page).not_to have_content("Active")
      expect(page).not_to have_content("Closed")
    end
  end

  it "changes to active when a user enters the room" do
    room = Room.new(name: "Mocking Library", state: "pending")
    room.choices.build(title: "Rspec Mocks")
    room.choices.build(title: "Mocha")
    room.save

    page.visit room_path(room)

    page.within("#room-show") do
      expect(page).to have_content("Active")
    end
  end

  it "has a button for closing current topic which can only be used room creator" do
    page.visit root_path
    mock_omniauth_user

    page.within("#github-login .right") do
      page.click_on "Login with GitHub"
    end

    room = Room.new(name: "Git Practices")
    room.choices.build(title: "Rebase")
    room.choices.build(title: "Merge with master")
    room.save

    page.visit room_path(room)

    expect(page).not_to have_button("Close this Topic")

    room.update(user_id: User.first.id)

    page.visit room_path(room)

    expect(page).to have_button("Close this Topic")
  end
end
