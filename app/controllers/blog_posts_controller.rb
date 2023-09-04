class BlogPostsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def index
    @blog_posts = user_signed_in? ? BlogPost.most_recent : BlogPost.published.most_recent
  end

  def show
    @blog_post = BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found"
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      redirect_to blog_post_path(@blog_post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @set_blog_post
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found"
  end

  def update
    @set_blog_post

    if @blog_post.update(blog_post_params)
      redirect_to blog_post_path(@blog_post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @set_blog_post
    @blog_post.destroy

    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found"
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :published_at)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found"
  end
end

###
