class ApplicationController < ActionController::Base
  # ログイン前の権限制限
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  # ↑デフォルトでのフラッシュメッセージの追加



  # フラッシュメッセージの追加。deviseのデフォルトは/LifeWorth/config/locales/devise.en.ymlより削除

  def after_sign_out_path_for(resource_or_scope)
    flash[:success] = "Signed out completed successfully. Please come again."
    if resource_or_scope != :is_admin
      root_path
    elsif resource_or_scope == :is_admin
      home_about_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :email, :telephone])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
  end

end
