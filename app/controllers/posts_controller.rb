class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 15)
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 15)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = current_user.posts.build if logged_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿されました"
      redirect_to posts_url
    else
      @user = current_user
      @feed_items = []
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to posts_url
    # redirect_to request.referrer || root_url
    # redirect_back(fallback_location: root_url)
  end

  private
    def post_params
      params.require(:post).permit(:content, :picture)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
