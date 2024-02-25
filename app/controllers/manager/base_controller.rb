# frozen_string_literal: true

module Manager
  class BaseController < ApplicationController
    layout 'manager'
    before_action :authenticate_user!

    def check_authorize(record, query = nil)
      authorize(record, query, policy_class: "#{controller_path.classify}Policy".constantize)
    end
  end
end
