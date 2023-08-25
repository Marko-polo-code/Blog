class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found"
  end

  def new
    @blog_post = BlogPost.new
  end
end

###
