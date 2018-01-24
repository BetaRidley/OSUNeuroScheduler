class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    after_sign_in_path_for(params[:confirmation_token])
  end
end
