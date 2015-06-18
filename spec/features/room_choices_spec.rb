require "rails_helper"

RSpec.describe "Room with choices" do
  it "displays the choices down the side of the room page" do
    room = Room.new(name: "Rspec config")
    choice1 = room.choices.build(title: "Rspec.describe")
    choice2 = room.choices.build(title: "Just describe")
    room.save

    page.visit room_path(room)

    page.within("#choices") do
      expect(page).to have_content(choice1.title)
      expect(page).to have_content(choice2.title)
    end
  end
end
