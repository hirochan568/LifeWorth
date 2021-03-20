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
    redirect_to blog_details_path(@blog)
  end

  def index
    @blogs = Blog.all

  end

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs

  end

  def details
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @blog_comment = BlogComment.new
  end


  def edit
    @categories = Category.all
    @blog = Blog.find(params[:id])
  end



  def update
    @blog = Blog.find(params[:id])
    @user = @blog.user
    if @blog.update(blog_params)
      redirect_to blog_path(@user), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body, :image, :category_id)
  end

end
