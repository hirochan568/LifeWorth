class QuestionCommentsController < ApplicationController
  
  def create
    question = Question.find(params[:question_id])
    comment = current_user.question_comments.new(question_comment_params)
    comment.question_id = question.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @question = Question.find(params[:question_id])
    question_comment = @question.question_comments.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def question_comment_params
    params.require( :question_comment).permit(:comment)
  end


end