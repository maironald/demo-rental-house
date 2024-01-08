# frozen_string_literal: true

module Users
  class BaseController < ApplicationController
    before_action :authenticate_user!
  end
end
