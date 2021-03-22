class BlogsController < ApplicationController

  def new
    @blog = Blog.new
    @categories = Category.all
  end

  # 投稿データの保存
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if  @blog.save
      flash[:success] = 'Post is complete！'
      redirect_to user_blog_path(current_user)
    else
      @categories = Category.all
      render :new
    end

  end

  def index
    @blogs = Blog.all

  end

  def show
    @blogs =  Blog.where(user_id: params[:id])
    @user = User.find(params[:id])
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
      flash[:success] = "You have updated article successfully."
      redirect_to  user_blog_path(current_user)
    else
      @categories = Category.all
      render "edit"
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    if @blog.destroy
      flash[:success] = "You have destroyed article successfully."
      @user = @blog.user
      redirect_to user_blog_path(@user)
    else
      @blogs =  Blog.where(user_id: params[:id])
      @user = User.find(params[:id])
      render "show"
    end
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :body, :image, :category_id)
  end

end
