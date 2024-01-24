# frozen_string_literal: true

if Rails.env.development?
  BetterHtml.configure do |config|
    config.allow_single_quoted_attributes = true
  end
end
