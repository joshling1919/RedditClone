class PostsController < ApplicationController
  before_action :is_logged_in?
  before_action :owned_post, only: [:edit, :update, :destroy]


  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end


  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :user_id, sub_ids: [])
  end


  def owned_post
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      flash[:errors] = ['You cant edit someone elses post']
      redirect_to post_url(@post.id)
    end
  end
end
