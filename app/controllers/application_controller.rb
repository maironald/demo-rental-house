# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protected

  def check_authorize(record, query = nil)
    authorize(record, query, policy_class: "#{controller_path.classify}Policy".constantize)
  end
end
