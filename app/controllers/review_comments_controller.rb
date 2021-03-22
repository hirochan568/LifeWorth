class ReviewCommentsController < ApplicationController
  
  def create
    review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = review.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @review = Review.find(params[:review_id])
    review_comment = @review.review_comments.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def review_comment_params
    params.require( :review_comment).permit(:comment)
  end


end
