class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  # ↑デフォルトでのフラッシュメッセージの追加

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインに成功しました"
    if current_user.is_admin?
      users_path(resource.id)
    else
      my_page_path(resource.id)
    end
  end

  def after_sign_up_path_for(resource)
    flash[:notice] = "登録に成功しました"
     if current_user.is_admin?
     users_path(resource.id)
     else
     my_page_path(resource.id)
     end

  # current_user.is_admin? ? root_path : home_about_path
  # case current_user.is_admin?
  #   when true
  #     root_path
  #   when false
  #     home_about_path
  # end
  end

  def after_sign_out_path_for(resource_or_scope)
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
