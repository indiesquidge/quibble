require "rails_helper"

RSpec.describe Message do
  it "must have a body" do
    expect(Message.new.valid?).not_to be
    expect(Message.new(body: "hello world").valid?).to be
  end
end
