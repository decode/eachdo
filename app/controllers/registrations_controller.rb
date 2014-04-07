class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def update
    @user = current_user
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank? && params[:user][:current_password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      params[:user].delete(:current_password)
    end

    if @user.update_attributes(user_params)
      #if @user.update_attributes(params[:user])
      redirect_to '/users/edit', :notice => "User updated."
    else
      redirect_to '/users/edit', :alert => "Unable to update user."
    end
  end

  protected
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache)}
  end

  private  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar)
  end
end
