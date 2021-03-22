class UsersController < ApplicationController
  # beforeアクションによりupdateとdestroyのみゲストか確かめる
  before_action :ensure_normal_user, only: %i[update destroy]

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'Guest users cannot be changed or deleted.'
    end
  end

  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to  my_page_path, success: '登録に成功しました'
  end

  def people
    @users = User.all


  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :telephone)
  end

end
