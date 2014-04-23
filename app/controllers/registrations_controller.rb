class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
                             @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
                           else
                             # remove the virtual current_password attribute
                             # update_without_password doesn't know how to ignore it
                             params[:user].delete(:current_password)
                             @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
                           end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      #redirect_to after_update_path_for(@user)
      render "edit"
    else
      render "edit"
    end
  end

  protected
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache)}
  end

  private  
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present?
  end
end
