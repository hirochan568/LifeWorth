class ReviewCommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = @review.id
    unless comment.save
      render 'error'
      # error.js.erbを参照
    end
    # create.js.erbを参照
  end

  def destroy
    @review = Review.find(params[:review_id])
    review_comment = @review.review_comments.find(params[:id]).destroy
    # destroy.js.erbを参照
  end

  private

  def review_comment_params
    params.require( :review_comment).permit(:comment)
  end


end
