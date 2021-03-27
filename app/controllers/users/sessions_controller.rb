# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  # ゲストユーザー作成

  def new_guest
    user = User.guest
    sign_in user
    redirect_to my_page_path(current_user), success: 'You have Signed in as a guest user.'
  end

  # フラッシュメッセージの追加。deviseのデフォルトは/LifeWorth/config/locales/devise.en.ymlより削除

  def after_sign_in_path_for(resource)
    flash[:success] = "Signed in completed successfully."
     if current_user.is_admin?
     users_path(resource.id)
     else
     users_path(resource.id)
     end
  end


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
