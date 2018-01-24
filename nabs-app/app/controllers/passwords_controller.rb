class PasswordsController < ApplicationController
  skip_before_action :check_pass_changed
  def edit
  end

  def update
    if current_user.update_with_password(user_params)
      current_user.password_changed = true
      current_user.save
      sign_in(current_user, :bypass => true)
      flash[:notice] = 'Password updated'
      redirect_to authenticated_root_path
    else
      current_user.rollback!
      flash[:error] = 'Error updating password'
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end
