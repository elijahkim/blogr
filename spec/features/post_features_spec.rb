require "rails_helper"

RSpec.feature "crudding posts" do
  let(:user) { create(:user) }

  scenario "As a user I can create a post", :js do
    sign_in(user)
    visit new_post_path

    fill_in "Title", with: "This is my blog post"
    set_post_body("# This is my blog post")
    click_on "Create Post"

    within("#flash"){ expect(page).to have_content("Post created successfully") }
    expect(page).to have_content("This is my blog post")
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
    within("#flash") do
      expect(page).to have_content("Post updated successfully")
    end
  end

  scenario "As a post owner I can delete a post", :js do
    sign_in(user)
    post = create(:post, user: user)
    visit post_path(post)

    page.accept_confirm { click_on "Delete Post" }

    expect(page).to_not have_content(post.title)
    within("#flash") do
      expect(page).to have_content("Post deleted successfully")
    end
  end

  def set_post_body(content)
    page.execute_script("editor.importFile(null, '#{content}')")
  end
end
