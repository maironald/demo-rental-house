# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def render_turbo_stream_flash_messages
    turbo_stream.prepend('flash', partial: 'shared/flash')
  end

  def form_error_notification(object)
    return unless object.errors.any?

    tag.div class: 'error-message' do
      object.errors.full_messages.to_sentence.capitalize
    end
  end

  # controller_path is the name of the controller in routes.rb as a string
  def active_link_class(patterns, options = { class: 'active' })
    routeto = "#{controller_path}##{action_name}"
    matched = patterns.any? { |pattern| (pattern.include?('#') ? (pattern == routeto) : (pattern == controller_path)) }
    matched ? options[:class] : nil
  end

  def format_to_vnd(amount)
    number_to_currency(amount, unit: '₫', separator: ',', delimiter: '.', precision: 0)
  end
end
