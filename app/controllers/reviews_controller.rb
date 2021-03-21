class ReviewsController < ApplicationController
  
  def new
    @review = review.new
    @categories = Category.all
  end

  # 投稿データの保存
  def create
    @review = review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_to review_details_path(@review)
  end

  def index
    @reviews = review.all

  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews

  end

  def details
    @review = review.find(params[:id])
    @user = @review.user
    @review_comment = reviewComment.new
  end


  def edit
    @categories = Category.all
    @review = review.find(params[:id])
  end



  def update
    @review = review.find(params[:id])
    @user = @review.user
    if @review.update(review_params)
      redirect_to review_path(@user), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @review = review.find(params[:id])
    @review.destroy
    @user = @review.user
    redirect_to review_path(@user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :image, :category_id)
  end

end

