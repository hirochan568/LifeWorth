class QuestionsController < ApplicationController

  def new
    @question = Question.new
    @categories = Category.all
  end

  # 投稿データの保存
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if  @question.save
      flash[:success] = 'Post is complete！'
      redirect_to user_question_path(current_user)
    else
      @categories = Category.all
      render :new
    end

  end

  def index
    @categories = Category.all
    if params[:category_id]
      @questions = Question.where(category_id: params[:category_id])
    else
       @questions = Question.all
    end
  end

  def show
    @questions =  Question.where(user_id: params[:id])
    @user = User.find(params[:id])
  end

  def details
    @question = Question.find(params[:id])
    @user = @question.user
    @question_comment = QuestionComment.new
  end


  def edit
    @categories = Category.all
    @question = Question.find(params[:id])
  end



  def update
    @question = Question.find(params[:id])
    @user = @question.user
    if @question.update(question_params)
      flash[:success] = "You have updated article successfully."
      redirect_to  user_question_path(current_user)
    else
      @categories = Category.all
      render "edit"
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:success] = "You have destroyed article successfully."
      @user = @question.user
      redirect_to user_question_path(@user)
    else
      @questions =  Question.where(user_id: params[:id])
      @user = User.find(params[:id])
      render "show"
    end
  end

  def favorite
    question_ids = QuestionFavorite.where(user_id: current_user.id).select("question_id as id")
    @questions =  Question.where(id: question_ids)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :image, :category_id, :solution)
  end

end