# frozen_string_literal: true

class SettingsController < BaseController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  before_action :set_setting, only: %i[edit update]
  def edit
    %i[price_water price_electric price_security price_internet price_trash].each do |attr|
      @setting[attr] = format_to_vnd_not_unit(@setting[attr])
    end
  end

  def update
    remove_decimal_separator(params[:setting], %i[price_electric price_water price_security price_internet price_trash])
    respond_to do |format|
      if current_user.setting.update(setting_params)
        reload_settings(format, type: :success, message: 'You change the value price of all services room successfully.')
      else
        render_errors(format, :edit)
      end
    end
  end

  def setting_params
    params.require(:setting).permit(:price_electric, :price_water, :price_security, :price_internet, :price_trash)
  end

  def set_setting
    @setting = current_user.setting
  end

  def count_people_in_room
    @room_total = current_user.rooms.count
    @room_used = Renter.where(room_id: current_user.rooms.pluck(:id), renter_type: 'main').count
    @room_left = @room_total - @room_used
  end

  def reload_settings(format, options = {})
    @rooms = current_user.rooms.all
    @total_rooms = @rooms.count
    count_people_in_room
    @pagy, @rooms = pagy(@rooms, items: 9)
    format.html { redirect_to rooms_path, notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('room_list', partial: 'rooms/table', locals: { rooms: @rooms, pagy: @pagy, total_rooms: @total_rooms, room_used: @room_used, room_left: @room_left }),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def render_errors(format, action)
    format.html { render action, status: :unprocessable_entity }
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_setting', partial: 'settings/form')] }
  end

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      params_hash[key] = params_hash[key].delete('.')
    end
  end
end
