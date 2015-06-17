require "rails_helper"

RSpec.describe Message do
  it "must have a body" do
    expect(Message.new).not_to be_valid
    expect(Message.new(body: "hello world")).to be_valid
  end
end
