require "rails_helper"

RSpec.describe "User in a chatroom", type: :feature do
  it "sees a list of recent messages" do
    chatroom = Room.create!(name: "lonely")
    mes_1 = chatroom.messages.create!(body: "Hey guys what's up")
    mes_2 = chatroom.messages.create!(body: "I'm so alone")
    mes_3 = chatroom.messages.create!(body: "I wish someone would join us.")
    mes_4 = chatroom.messages.create!(body: "Okay, well, goodbye")

    page.visit room_path(chatroom)
    page.within("#recent-messages") do
      expect(page).to have_content(mes_1.body)
      expect(page).to have_content(mes_2.body)
      expect(page).to have_content(mes_3.body)
      expect(page).to have_content(mes_4.body)
    end
  end

  it "can post a new message via form" do
    room = Room.create!(name: "new_room")
    page.visit room_path(room)

    page.within("#recent-messages") do
      expect(page).not_to have_content("Hello world")
    end

    page.within("#new-message") do
      fill_in "message[body]", with: "Hello world"
      page.click_on "Create message"
    end

    page.within("#recent-messages") do
      expect(page).to have_content("Hello world")
    end
  end
end
