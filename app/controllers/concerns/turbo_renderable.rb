# frozen_string_literal: true

module TurboRenderable
  extend ActiveSupport::Concern

  def render_result(name_success:, name_error:, result:, path:, model:, action:, message: nil, func: nil) # rubocop:disable Metrics/ParameterLists
    respond_to do |format|
      if result
        message ||= t("common.#{action == :new ? 'create' : 'update'}.success", model:)

        format.html { redirect_to path, notice: message }
        format.turbo_stream do
          yield func if block_given?
          flash.now[:success] = message
          render_result_success(name: name_success)
        end
      else
        format.html { render action, status: :unprocessable_entity }
        format.turbo_stream { turbo_stream_reform(frame_name: name_error) }
      end
    end
  end

  def render_result_destroy(name:, path:, model:, func:)
    message = t('common.delete.success', model:)
    respond_to do |format|
      format.html { redirect_to path, notice: message }
      format.turbo_stream do
        yield func if block_given?
        flash.now[:success] = message
        render_result_success(name:)
      end
    end
  end

  def render_result_success(name:, locals: {}, partial: 'table', modal: 'my_modal_4')
    render turbo_stream: turbo_action_base(name:, locals:, partial:, modal:)
  end

  def render_result_list(name:, locals: {}, partial: 'list')
    render turbo_stream: [
      turbo_stream.replace(name, partial:, locals:)
    ]
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
