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
      redirect_to user_blog_path(current_user)
    else
      @categories = Category.all
      render :new
    end

  end

  def index
    @questions = Question.all

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
    if @question.update(blog_params)
      flash[:success] = "You have updated article successfully."
      redirect_to  user_blog_path(current_user)
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
      redirect_to user_blog_path(@user)
    else
      @questions =  Question.where(user_id: params[:id])
      @user = User.find(params[:id])
      render "show"
    end
  end


  private

  def question_params
    params.require(:question).permit(:title, :body, :image, :category_id, :solution)
  end

end