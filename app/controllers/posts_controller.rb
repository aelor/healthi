class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      latest_post = Post.last
      WebsocketRails[:posts].trigger 'new', latest_post
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
