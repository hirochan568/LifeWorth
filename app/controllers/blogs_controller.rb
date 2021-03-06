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
      redirect_to blog_details_path(@blog)
    else
      @categories = Category.all
      render :new
    end
  end

  def index
    @categories = Category.all
    if params[:category_id]
      @blogs = Blog.where(category_id: params[:category_id])
    else
       @blogs = Blog.all
    end
  end

  def show
    @categories = Category.all
    @user = User.find(params[:id])
    if params[:category_id]
      @blogs = Blog.where(category_id: params[:category_id]).where(user_id: params[:id])
      #別の記載方法： @blogs = Blog.where(category_id: params[:category_id], user_id: params[:id])
    else
      @blogs = Blog.where(user_id: params[:id])
    end
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
      redirect_to  blog_details_path(@blog)
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

  def favorite
    #blog_favoriteからuser_idを条件にデータを取得する
    blog_ids = BlogFavorite.where(user_id: current_user.id).select("blog_id as id")
    #blogからblog_idを条件にデータを取得する
    @blogs =  Blog.where(id: blog_ids)
    #1行にすると@blogs =  Blog.where(id: BlogFavorite.where(user_id: current_user.id).select("blog_id as id"))
    #別の書き方 @blogs =  Blog.where(id: current_user.blog_favorites.map{|bf| bf.blog_id})
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body, :image, :category_id)
  end

end
