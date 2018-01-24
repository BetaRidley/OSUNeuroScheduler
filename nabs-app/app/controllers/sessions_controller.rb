class SessionsController < Devise::SessionsController
    skip_before_action :check_pass_changed
    def create
      if current_user and not current_user.password_changed
        current_user.confirmed_at = nil
        current_user.save
      end
      super
    end
end
