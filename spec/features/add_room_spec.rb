# require "rails_helper"

# RSpec.describe "Authenticated User", type: :feature do
#   it "can add a chat room", js: true do
#     page.visit root_path
#     mock_omniauth_user

#     within ".right" do
#       page.click_on "Login with GitHub"
#     end

#     within "#new-room-form" do
#       page.fill_in("topic-field", with: "Testing Suite")
#       page.fill_in("choice-field", with: "rspec")
#       page.click_on "Create room"
#     end

#     page.within("#room-show") do
#       expect(page).to have_content("Testing Suite")
#     end
#   end
# end

# describe "Unauthenticated User" do
#   it "must login before creating a new room", js: true do
#     page.visit root_path
#     expect(page).to have_content("LOGIN TO CREATE ROOM")
#     fill_in("topic-field", with: "Testing Suite")
#     fill_in("choice-field", with: "rspec")
#     click_on("Login to create room")
#     expect(page).to have_content("Create New Room")
#   end
# end
