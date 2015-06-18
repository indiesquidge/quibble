require "rails_helper"

RSpec.describe Choice do
  it "has a #chosen_display to prettify the views" do
    success = Choice.new(title: "Success", chosen: true)
    rejected = Choice.new(title: "Success", chosen: false)
    expect(success.chosen_display).to eq("green lighten-1 bold")
    expect(rejected.chosen_display).to eq("red lighten-4 strikethrough")
  end
end
