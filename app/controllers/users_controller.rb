class UsersController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def people
    @users = User.all
    

  end

  private

  def customer_params
    params.require(:user).permit(:name, :nickname, :email, :telephone)
  end

end
