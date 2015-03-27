require "rails_helper"

RSpec.feature "crudding posts" do
  let(:user) { create(:user) }

  scenario "As a user I can create a post" do
    sign_in(user)
    visit new_post_path

    fill_in "Title", with: "This is my blog post"
    fill_in "Content", with: "This is some content"
    click_on "Create Post"

    within("#flash"){ expect(page).to have_content("Post created successfully") }
    expect(page).to have_content("This is my blog post")
  end
end
