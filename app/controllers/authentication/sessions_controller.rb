# frozen_string_literal: true

module Authentication
  class SessionsController < Devise::SessionsController
    protected

    def after_sign_in_path_for(resource)
      if resource && resource.errors.any?
        flash[:notice] = "Login failed. Please check your credentials."
        return new_user_session_path
      else
        return resource.has_role?(:admin) ? admin_root_path : users_root_path
      end
    end
  end
end
