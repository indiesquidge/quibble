require "rails_helper"

RSpec.describe MessagesController, type: :controller, js: true do
  it "can respond with all ideas" do
    Message.create(body: "new message")
    Message.create(body: "another new message")
    get :index, format: :json

    JSON.parse(response.body, symbolize_names: true)
    messages= Message.all

    expect(response.code).to eq("200")
    expect(messages.first[:body]).to eq("new message")
    expect(messages.second[:body]).to eq("another new message")
  end

  xit "can create a new message" do
    post :create, message: { body: "created new message" }, format: :json

    JSON.parse(response.body, symbolize_names: true)
    message = Message.first

    expect(message.body).to eq("created new message")
  end
end
