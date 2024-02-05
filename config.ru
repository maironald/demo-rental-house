# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'cloudinary'

Cloudinary.config_from_url('cloudinary://API_KEY:API_SECRET@CLOUD_NAME')
Cloudinary.config do |config|
  config.secure = true
end

run Rails.application
Rails.application.load_server
