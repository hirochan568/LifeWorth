class QuestionFavoritesController < ApplicationController

  def create
    question = Question.find(params[:question_id])
    question_favorite = current_user.question_favorites.new(question_id: question.id)
    question_favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    question = Question.find(params[:question_id])
    question_favorite = current_user.question_favorites.find_by(question_id: question.id)
    question_favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end
