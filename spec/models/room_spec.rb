require "rails_helper"

RSpec.describe Room do
  it "must have a name" do
    expect(Room.new).not_to be_valid
    room = Room.new(name: "my room")
    room.choices.build(title: "trivial choice")
    expect(room).to be_valid
  end

  context("slug attribute") do
    it "parameterizes the name for the slug" do
      room = Room.new(name: "hello world or poopin")
      room.choices.build(title: "hello world")
      room.slug_it_up
      expect(room.slug).to eq("hello-world-or-poopin")
    end

    it "uses the id if name can't be parameterized" do
      room = Room.new(name: "∂ƒ∆ƒ∆")
      room.choices.build(title: "poopin")
      room.slug_it_up
      expect(room.slug).to eq(room.id.to_s)
    end

    it "uses id if any parameterization fails" do
      room = Room.new(name: "†his is delicious π")
      room.choices.build(title: "Yes")
      room.choices.build(title: "or yes")
      room.slug_it_up
      expect(room.slug).to eq(room.id.to_s)
    end
  end

  it "must have at least one choice" do
    room = Room.new(name: "test")
    expect(room).not_to be_valid
    room.choices.build(title: "trivial choice")
    room.choices.build(title: "other trivial choice")
    expect(room.save).to be
    expect(room.choices.count).to eq(2)
  end

  context("state attribute") do
    it "has three possible states" do
      pending = Room.new(state: "pending")
      active = Room.new(state: 1)
      closed = Room.new(state: :closed)

      expect(pending.state).to eq("pending")
      expect(active.state).to eq("active")
      expect(closed.state).to eq("closed")
    end

    it "has a display state for pretty factor" do
      expect(Room.new.display_state).to eq("Pending")
      expect(Room.new(state: "active").display_state).to eq("Active")
      expect(Room.new(state: "closed").display_state).to eq("Closed")
    end

    it "has a display state which changes depending on whether it is being viewed" do
      pending = Room.new
      active = Room.new(state: "active")
      closed = Room.new(state: "closed")
      expect(pending.display_current_state).to eq("Active")
      expect(active.display_current_state).to eq("Active")
      expect(closed.display_current_state).to eq("Closed")
    end
  end
end
