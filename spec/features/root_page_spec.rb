require "rails_helper"

OmniAuth.config.test_mode = true

RSpec.describe "User on root path", type: :feature do
  it "sees a list of available chatrooms" do
    chatroom1 = Room.new(name: "room 1")
    chatroom1.choices.build(title: "austin")
    chatroom2 = Room.new(name: "room 2")
    chatroom2.choices.build(title: "dj")
    chatroom2.save!
    chatroom1.save!

    page.visit root_path
    page.within(".rooms") do
      expect(page).to have_link(chatroom1.name)
      expect(page).to have_link(chatroom2.name)
    end
  end

  it "can login via GitHub" do
    page.visit root_path
    user = mock_omniauth_user

    page.within("#github-login .right") do
      page.click_on "Login with GitHub"
    end

    expect(page).to have_content("Welcome #{user.info.nickname}!")
  end
end
