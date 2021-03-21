class QuestionsController < ApplicationController

  def new
    @question = question.new
    @categories = Category.all
  end

  # 投稿データの保存
  def create
    @question = question.new(question_params)
    @question.user_id = current_user.id
    @question.save
    redirect_to question_details_path(@question)
  end

  def index
    @questions = question.all

  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions

  end

  def details
    @question = question.find(params[:id])
    @user = @question.user
    @question_comment = questionComment.new
  end


  def edit
    @categories = Category.all
    @question = question.find(params[:id])
  end



  def update
    @question = question.find(params[:id])
    @user = @question.user
    if @question.update(question_params)
      redirect_to question_path(@user), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @question = question.find(params[:id])
    @question.destroy
    @user = @question.user
    redirect_to question_path(@user)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :image, :solution, :category_id)
  end

end

