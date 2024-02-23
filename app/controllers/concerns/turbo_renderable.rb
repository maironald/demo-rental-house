# frozen_string_literal: true

module TurboRenderable
  extend ActiveSupport::Concern

  def render_result(result, frame_name, model)
    message = t("common.#{action_name == 'create' ? 'create' : 'edit'}.success", model:)
    respond_to do |format|
      if result
        format.html { redirect_to rooms_path, notice: message }
        format.turbo_stream do
          flash[:success] = message
          render_turbo_table(frame_name, { room: @room })
        end
      else
        turbo_stream_reform(frame_name)
      end
    end
  end

  def render_turbo_stream(arr)
    render turbo_stream: turbo_stream(arr)
  end

  def render_turbo_table(frame_name, locals = {}, flash = '')
    render turbo_stream: turbo_stream_tables(frame_name, locals:, flash:)
  end

  def turbo_stream_tables(frame_name, locals = {}, partial = 'table', modal = 'my_modal_4', flash = '') # rubocop:disable Metrics/ParameterLists
    [
      turbo_stream.replace(frame_name, partial:, locals:),
      turbo_stream.remove(modal),
      flash.present? ? turbo_stream.prepend('flash', partial: 'shared/flash') : nil
    ]
  end

  def turbo_stream_reform(frame_name, partial = 'form', locals = {})
    render turbo_stream: [
      turbo_stream.replace(frame_name, partial:, locals:)
    ], status: :unprocessable_entity
  end
end
