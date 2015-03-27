require 'rails_helper'

RSpec.feature "As a guest" do
  scenario "I can create an account" do
    visit new_user_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Sign up"

    expect(page).to have_content "Created user successfully"
  end

  scenario "I can sign in" do
    user = create(:user)
    visit new_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password_digest
    click_on "Sign in"
  end
end
