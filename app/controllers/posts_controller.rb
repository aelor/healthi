class PostsController < ApplicationController

  def new
    @post = current_user.posts.build
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    if params[:notif]
        current_user.not_seen.delete(@post.id)
        current_user.save
    end
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      latest_post = Post.last
      WebsocketRails[:posts].trigger 'new', latest_post
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  def get_recent_posts
    @user = current_user
    @posts = Post.find(current_user.not_seen)
    render :partial => "recent_posts"
  end

  def update_not_seen
    @post = Post.find(params[:id])
    @user = User.find_by_email(current_user.email)
    if @user.not_seen and !@user.not_seen.include?(@post.id)
      @user.not_seen << @post.id
    else
      @user.not_seen = [@post.id]
    end
    @user.save
    render :nothing => true
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
