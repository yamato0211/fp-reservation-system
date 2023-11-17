require "rails_helper"

RSpec.describe "users", type: :system do
    it "GET /users/sign_in" do
        visit "/users/sign_in"
        expect(page).to have_selector "h2", text: "Log in"
    end

    it "GET /users/sign_up" do
        visit "/users/sign_up"
        expect(page).to have_selector "h2", text: "Sign up"
    end
end