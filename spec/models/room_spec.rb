require "rails_helper"

describe "Room" do
  it "must have a name" do
    expect(Room.new).not_to be_valid
    room = Room.new(name: "my room")
    room.choices.build(title: "some trivial choice")
    expect(room.save).to be
  end

  it "must have at least one choice", js: true do
    room = Room.new(name: "test")
    expect(room).not_to be_valid
    room.choices.build(title: "some trivial choice")
    room.choices.build(title: "some other trivial choice")
    expect(room.save).to be
    expect(room.choices.count).to eq(2)
  end
end
