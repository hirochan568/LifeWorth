class BlogFavoritesController < ApplicationController

  def create
    blog = Blog.find(params[:blog_id])
    blog_favorite = current_user.blog_favorites.new(blog_id: blog.id)
    blog_favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    blog = Blog.find(params[:blog_id])
    blog_favorite = current_user.blog_favorites.find_by(blog_id: blog.id)
    blog_favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end