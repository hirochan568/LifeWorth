class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @categories = Category.all
  end

  # 投稿データの保存
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if  @review.save
      flash[:success] = 'Post is complete！'
      redirect_to review_details_path(@review)
    else
      @categories = Category.all
      render :new
    end

  end

  def index
    @categories = Category.all
    if params[:category_id]
      @reviews = Review.where(category_id: params[:category_id])
    else
       @reviews = Review.all
    end
  end

  def show
    @categories = Category.all
    @user = User.find(params[:id])
    if params[:category_id]
      @reviews = Review.where(category_id: params[:category_id], user_id: params[:id])
    else
      @reviews = Review.where(user_id: params[:id])
    end
  end

  def details
    @review = Review.find(params[:id])
    @user = @review.user
    @review_comment = ReviewComment.new
  end


  def edit
    @categories = Category.all
    @review = Review.find(params[:id])
  end



  def update
    @review = Review.find(params[:id])
    @user = @review.user
    if @review.update(review_params)
      flash[:success] = "You have updated article successfully."
      redirect_to  review_details_path(@review)
    else
      @categories = Category.all
      render "edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      flash[:success] = "You have destroyed article successfully."
      @user = @review.user
      redirect_to user_review_path(@user)
    else
      @reviews =  Review.where(user_id: params[:id])
      @user = User.find(params[:id])
      render "show"
    end
  end

  def favorite
    review_ids = ReviewFavorite.where(user_id: current_user.id).select("review_id as id")
    @reviews =  Review.where(id: review_ids)
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :image, :category_id, :evaluation)
  end

end
