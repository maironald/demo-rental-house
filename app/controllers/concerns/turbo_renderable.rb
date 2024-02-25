# frozen_string_literal: true

module TurboRenderable
  extend ActiveSupport::Concern

  def render_result(result:, path:, model:, action:)
    respond_to do |format|
      if result
        message = t("common.#{action == :new ? 'create' : 'update'}.success", model:)

        format.html { redirect_to path, notice: message }
        format.turbo_stream do
          prepare_index
          flash.now[:success] = message
          render_result_success(name: 'room_list')
        end
      else
        format.html { render action, status: :unprocessable_entity }
        format.turbo_stream { turbo_stream_reform(frame_name: 'new_room') }
      end
    end
  end

  def render_result_success(name:, locals: {}, partial: 'table', modal: 'my_modal_4')
    render turbo_stream: turbo_action_base(name:, locals:, partial:, modal:)
  end

  def turbo_stream_reform(frame_name:, partial: 'form')
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
