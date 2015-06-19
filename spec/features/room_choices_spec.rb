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

  it "sets a random choice as the chosen room when the room is closed", js: true do
    page.visit root_path
    mock_omniauth_user

    page.click_on "Login to create room"

    fill_in("topic-field", with: "Pens or pencils")
    fill_in("choice-field", with: "Pencil")
    find(:css, "#add-input-field").click
    within all('#choice-field-section').last do
      fill_in("choice-field", with: "Pen")
    end

    page.click_on "Create Room"

    room = Room.find_by(slug: current_path.sub(/\/rooms\//, ""))
    choice1_before = room.choices.first
    choice2_before = room.choices.last
    expect(choice1_before.chosen?).to eq(false)
    expect(choice2_before.chosen?).to eq(false)

    page.click_on "Close this Topic"

    choice1_after = room.choices.first
    choice2_after = room.choices.last

    expect(choice1_after.chosen? || choice2_after.chosen?).to eq(true)
  end

  context "closed room" do
    it "displays the chosen choice as green" do
      room = Room.new(name: "Before blocks", state: "closed")
      sad_choice = room.choices.build(title: "Yes")
      happy_choice = room.choices.build(title: "No", chosen: true)
      room.save

      page.visit room_path(room)

      within(".#{happy_choice.title}") do
        happy_choice.chosen_display.split(" ").each do |css_class|
          expect(page).to have_css(".#{css_class}")
        end
      end
    end

    it "displays non-chosen choices as red and strikeoutted" do
      room = Room.new(name: "Before blocks", state: "closed")
      sad_choice = room.choices.build(title: "Yes")
      happy_choice = room.choices.build(title: "No", chosen: true)
      room.save

      page.visit room_path(room)

      within(".#{sad_choice.title}") do
        sad_choice.chosen_display.split(" ").each do |css_class|
          expect(page).to have_css(".#{css_class}")
        end
      end
    end
  end
end
