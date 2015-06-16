require "rails_helper"

RSpec.describe "User in a chatroom", type: :feature do
  it "sees a list of recent messages" do
    chatroom1 = Room.create!(name: "lonely")
    mes_1 = chatroom1.messages.create!(body: "Hey guys what's up")
    mes_2 = chatroom1.messages.create!(body: "I'm so alone")
    mes_3 = chatroom1.messages.create!(body: "I wish someone would join us.")
    mes_4 = chatroom1.messages.create!(body: "Okay, well, goodbye")

    page.visit "/room/lonely"
    page.within("#recent-messages") do
      expect(page).to have_content(mes_1.body)
      expect(page).to have_content(mes_2.body)
      expect(page).to have_content(mes_3.body)
      expect(page).to have_content(mes_4.body)
    end
  end
end
