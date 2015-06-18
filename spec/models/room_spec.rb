require "rails_helper"

RSpec.describe Room do
  it "must have a name" do
    expect(Room.new).not_to be_valid
    room = Room.new(name: "my room")
    room.choices.build(title: "trivial choice")
    expect(room.save).to be
  end

  it "must have at least one choice" do
    room = Room.new(name: "test")
    expect(room).not_to be_valid
    room.choices.build(title: "trivial choice")
    room.choices.build(title: "other trivial choice")
    expect(room.save).to be
    expect(room.choices.count).to eq(2)
  end
  it "has three possible states" do
    pending = Room.new(state: "pending")
    active = Room.new(state: 1)
    closed = Room.new(state: :closed)

    expect(pending.state).to eq("pending")
    expect(active.state).to eq("active")
    expect(closed.state).to eq("closed")
  end

  it "has a default state of pending" do
    expect(Room.new.state).to eq("pending")
  end
end
