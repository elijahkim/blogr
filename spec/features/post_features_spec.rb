require "rails_helper"

RSpec.feature "crudding posts" do
  let(:user) { create(:user) }

  scenario "As a user I can create a post", :js do
    sign_in(user)
    visit new_post_path

    fill_in "Title", with: "This is my blog post"
    set_post_body("# This is my blog post")
    click_on "Create Post"

    expect_flash_with_content("Post created successfully")
    expect(page).to have_content("This is my blog post")
  end

  scenario "As a guest I cannot create a post" do
    visit new_post_path
    expect_flash_with_content(
      "You cannot create posts!"
    )
  end

  scenario "As a guest I cannot edit a post" do
    post = create(:post)
    visit edit_post_path(post)

    expect_flash_with_content(
      "You cannot edit this post!"
    )
  end

  scenario "As a user I cannot edit other people's posts" do
    post = create(:post)
    visit edit_post_path(post)

    expect_flash_with_content(
      "You cannot edit this post!"
    )
  end

  scenario "As a user I cannot delete other people's posts" do
    post = create(:post)
    visit post_path(post)
    click_on "Delete Post"

    expect_flash_with_content(
      "You cannot delete this post!"
    )
  end

  scenario "As a user I can see a post" do
    sign_in(user)
    post = create(:post, content: "#This is a posting")

    visit post_path(post)

    expect(page).to have_css("h1", text: "This is a posting")
  end

  scenario "As a post owner I can edit the post", :js do
    sign_in(user)
    post = create(:post, user: user)
    visit edit_post_path(post)

    set_post_body("#This is edited")
    click_on "Update Post"

    expect(page).to have_content("This is edited")
    expect_flash_with_content("Post updated successfully")
  end

  scenario "As a post owner I can delete a post", :js do
    sign_in(user)
    post = create(:post, user: user)
    visit post_path(post)

    page.accept_confirm { click_on "Delete Post" }

    expect(page).to_not have_content(post.title)
    expect_flash_with_content("Post deleted successfully")
  end

  def set_post_body(content)
    page.execute_script("editor.importFile(null, '#{content}')")
  end

  def expect_flash_with_content(content)
    within("#flash") do
      expect(page).to have_content(content)
    end
  end
end
