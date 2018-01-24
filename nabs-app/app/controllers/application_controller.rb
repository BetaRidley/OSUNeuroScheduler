class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_pass_changed
  def after_sign_in_path_for(resource)
    if !current_user.password_changed
      edit_passwords_path
    else
      authenticated_root_path
    end
  end

  def check_pass_changed
    if params[:confirmation_token] != nil
      if current_user and !current_user.password_changed
        sign_out(current_user)
      end
      user = User.find_by_confirmation_token(params[:confirmation_token])
      unless user.nil? or user.password_changed
        user.update(confirmed_at: nil)
      end
    end
    if current_user
      unless current_user.password_changed
        redirect_to edit_passwords_path
      end
    else

    end
  end
  def check_auth
    if current_user.nil?
      redirect_to unauthenticated_root_url, alert: "You must be logged in to view that page"
    end
  end

  def check_doctor_auth
    unless current_user.try(:doctor?) || current_user.try(:admin?)
      redirect_to unauthenticated_root_url, alert: "You must be an admin or doctor to view that page"
    end
  end
  
  def check_referring_clinic_auth
    unless (current_user.try(:doctor?) || current_user.try(:staff?) ) && current_user.try(:clinic).try(:referrer?)
      redirect_to home_index_path, alert: 'You are not authorized to view that page'
    end 
  end
  
  def check_referred_clinic_auth
    unless (current_user.try(:doctor?) || current_user.try(:staff?) ) && current_user.try(:clinic).try(:referred?)
      redirect_to home_index_path, alert: 'You are not authorized to view that page' 
    end  
  end

  def check_admin_auth
    unless current_user.try(:admin?)
      redirect_to home_index_path, alert: "You must be an admin to view that page"
    end
  end

end
