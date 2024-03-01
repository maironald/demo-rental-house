# frozen_string_literal: true

class BaseController < ApplicationController
  before_action :authenticate_user!

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      next if params_hash[key].blank? # Skip if the key is blank or nil

      params_hash[key] = params_hash[key].delete('.') if params_hash[key].respond_to?(:delete)
    end
  end
end
