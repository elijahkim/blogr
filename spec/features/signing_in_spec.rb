require 'rails_helper'

RSpec.feature "As a guest" do
  scenario "I can create an account" do
    visit sign_up_path

    fill_in "email", with: "user@example.com"
    fill_in "passworld", with: "password"
    click_on "create user"

    expect(page).to have_content "Created user successfully"
  end
end
