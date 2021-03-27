class BlogFavoritesController < ApplicationController
  before_action :set_blog

  def create
    @blog_favorite = current_user.blog_favorites.new(blog_id: @blog.id)
    @blog_favorite.save
    # redirect_back(fallback_location: root_path)←非同期
  end

  def destroy
    @blog_favorite = current_user.blog_favorites.find_by(blog_id: @blog.id)
    @blog_favorite.destroy
    # redirect_back(fallback_location: root_path)
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

end