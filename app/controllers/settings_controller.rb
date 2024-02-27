# frozen_string_literal: true

class SettingsController < BaseController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  before_action :prepare_index, only: %i[index edit update]
  before_action :set_setting, only: %i[edit update]
  before_action :set_room, only: %i[edit update]

  def index; end

  def edit
    %i[price_water price_electric price_security price_internet price_trash].each do |attr|
      @setting[attr] = format_to_vnd_not_unit(@setting[attr])
    end
  end

  def update
    remove_decimal_separator(params[:setting], %i[price_electric price_water price_security price_internet price_trash])
    render_result_action(@setting.update(setting_params), :edit)
  end

  private

  def setting_params
    params.require(:setting).permit(:price_electric, :price_water, :price_security, :price_internet, :price_trash)
  end

  def set_setting
    @setting = current_user.setting
  end

  def set_room
    @rooms = current_user.rooms
  end

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      params_hash[key] = params_hash[key].delete('.')
    end
  end

  def count_people_in_room
    @room_total = current_user.rooms.count
    @room_used = Renter.where(room_id: current_user.rooms.pluck(:id), renter_type: 'main').count
    @room_left = @room_total - @room_used
  end

  def render_result_action(result, action, path = rooms_path, model = 'the value price of all services room')
    name = 'room_list'
    frame_back_name = 'new_room'
    render_result(result:, path:, model:, action:, name:, frame_back_name:, partial: 'rooms/table')
  end

  def prepare_index
    total_rooms = current_user.rooms
    @room_total = total_rooms.size
    @room_used = total_rooms.rooms_rented.size
    @room_left = @room_total - @room_used
    @rooms = Rooms::GetListRoomsService.call(total_rooms, params)
    @total_rooms = @rooms.size
    @pagy, @rooms = pagy(@rooms, items: 9)
  end
end
