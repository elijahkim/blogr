class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML, autolink: true, tables: true
    )
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, flash: { success: "Post created successfully" }
    else
      flash[:error] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, flash: { success: "Post updated successfully" }
    else
      flash[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, flash: { success: "Post deleted successfully" }
    else
      redirect_to root_path, flash: { error: "Failed to delete post" }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
