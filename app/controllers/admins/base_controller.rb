# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    # TODO: Add authorization for admin before doing the admin controller.
    before_action :authenticate_user!
  end
end
