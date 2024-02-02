# frozen_string_literal: true

module Admins
  class DashboardController < BaseController
    def index
      @users = if params[:search].present?
                 User.where('email LIKE ?', "%#{params[:search]}%")
               else
                 User.with_role(:user)
               end
      @count = @users.count

      @pagy, @users = pagy(@users, items: 9)
    end
  end
end
