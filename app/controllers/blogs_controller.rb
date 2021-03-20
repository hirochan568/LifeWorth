class BlogsController < ApplicationController

  def new
    @blog = Blog.new
    @categories = Category.all
  end

  # 投稿データの保存
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.save
    redirect_to blogs_path
  end

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
  end


  def destroy
  end

  private

  def blog_params
    params.require(:blog).permit(:name, :body, :image, :category)
  end

end
