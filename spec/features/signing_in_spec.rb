require 'rails_helper'

RSpec.feature "As a guest" do
  scenario "I can create an account" do
    visit new_user_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Sign up"

    expect(page).to have_content "Created user successfully"
  end
end
