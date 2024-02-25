# frozen_string_literal: true

module TurboRenderable
  extend ActiveSupport::Concern

  def render_result_success(name:, locals:, partial: 'table', modal: 'my_modal_4')
    render turbo_stream: turbo_action_base(name:, locals:, partial:, modal:)
  end

  def turbo_stream_reform(frame_name:, partial:)
    render turbo_stream: [
      turbo_stream.replace(frame_name, partial:),
      turbo_stream.prepend('flash', partial: 'shared/flash')
    ], status: :unprocessable_entity
  end

  def turbo_action_base(name:, locals:, partial:, modal: 'my_modal_4')
    [
      turbo_stream.remove(modal),
      turbo_stream.replace(name, partial:, locals:),
      turbo_stream.prepend('flash', partial: 'shared/flash')
    ]
  end

  def render_turbo_stream(arr)
    render turbo_stream: turbo_stream(arr)
  end
end
