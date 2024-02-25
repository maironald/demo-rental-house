# frozen_string_literal: true

module Authentication
  class SessionsController < Devise::SessionsController
    protected

    def after_sign_in_path_for(resource)
      resource.has_role?(:admin) ? admins_root_path : users_root_path
    end
  end
end
