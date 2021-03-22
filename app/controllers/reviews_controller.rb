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
      redirect_to user_review_path(current_user)
    else
      @categories = Category.all
      render :new
    end

  end

  def index
    @reviews = Review.all

  end

  def show
    @reviews =  Review.where(user_id: params[:id])
    @user = User.find(params[:id])
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
      redirect_to  user_review_path(current_user)
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


  private

  def review_params
    params.require(:review).permit(:title, :body, :image, :category_id)
  end

end
