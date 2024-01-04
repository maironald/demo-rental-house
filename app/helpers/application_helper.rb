# frozen_string_literal: true

module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend('flash', partial: 'shared/flash')
  end

  def form_error_notification(object)
    return unless object.errors.any?

    tag.div class: 'error-message' do
      object.errors.full_messages.to_sentence.capitalize
    end
  end
end
