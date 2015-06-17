require "rails_helper"

describe "Room" do
  it "must have a name" do
    expect(Room.new).not_to be_valid
  end

  it "must have at least one choice" do
    expect(Room.new(name: "test")).not_to be_valid
  end
end
