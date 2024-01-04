# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protected

  def after_sign_in_path_for(resource)
    if resource.has_role?(:admin)
      admins_root_path
    elsif resource.has_role?(:user)
      users_root_path
    else
      root_path
    end
  end

  def check_authorize(record, query = nil)
    authorize(record, query, policy_class: "#{controller_path.classify}Policy".constantize)
  end
end
