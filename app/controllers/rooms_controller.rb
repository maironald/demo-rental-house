# frozen_string_literal: true

class RoomsController < BaseController
  before_action :prepare_index, only: %i[index]
  before_action :set_room, only: %i[show edit update destroy]

  def index; end

  def show; end

  def new
    @room = Room.new
  end

  def edit
    @room.price_room = format_to_vnd_not_unit(@room.price_room)
  end

  def create
    remove_decimal_separator(params[:room], %i[price_room])
    @room = current_user.rooms.new(room_params)
    render_result_action(@room.save, :new)
  end

  def update
    remove_decimal_separator(params[:room], %i[price_room])
    render_result_action(@room.update(room_params), :edit)
  end

  def destroy
    @room.really_destroy!
    render_destroy
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :length, :width, :price_room, :limit_residents, :description, :electric_amount_new, :electric_amount_old, :water_amout_new, :water_amout_old)
  end

  def check_amount(old, new)
    old <= new
  end

  def remove_decimal_separator(params_hash, keys)
    return unless params_hash.present? && keys.present?

    keys.each do |key|
      next if params_hash[key].blank?

      params_hash[key] = params_hash[key].delete('.')
    end
  end

  def render_result_action(result, action, path = rooms_path, model = "room: #{@room.name}")
    name = 'room_list'
    frame_back_name = 'new_room'
    render_result(result:, path:, model:, action:, name:, frame_back_name:)
  end

  def render_destroy
    render_result_destroy(
      name: 'room_list',
      path: rooms_path,
      model: @room.name,
      func: prepare_index
    )
  end

  def prepare_index
    total_rooms = current_user.rooms
    @room_info = Rooms::GetInfoRoomsService.call(total_rooms)
    @rooms = Rooms::GetListRoomsService.call(total_rooms, params)
    @total_rooms = @rooms.size
    @pagy, @rooms = pagy(@rooms, items: 9)
  end
end
