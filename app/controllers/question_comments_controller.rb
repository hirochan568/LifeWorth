class QuestionCommentsController < ApplicationController
  
  def create
    @question = Question.find(params[:question_id])
    comment = current_user.question_comments.new(question_comment_params)
    comment.question_id = @question.id
    unless comment.save
      render 'error'
      # error.js.erbを参照
    end
    # create.js.erbを参照
  end

  def destroy
    @question = Question.find(params[:question_id])
    question_comment = @question.question_comments.find(params[:id]).destroy
    # destroy.js.erbを参照
  end

  private

  def question_comment_params
    params.require( :question_comment).permit(:comment)
  end


end