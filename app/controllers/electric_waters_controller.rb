# frozen_string_literal: true

class ElectricWatersController < BaseController
  include ApplicationHelper
  before_action :prepare_index, only: %i[index show]
  before_action :set_room, only: %i[edit update show_detail]

  def index; end

  def show; end

  def new; end

  def edit; end

  def update
    render_result_action(@room.update(electric_water_params), :edit)
  end

  def show_detail; end

  private

  def electric_water_params
    params.require(:room).permit(:electric_amount_old, :electric_amount_new, :water_amout_old, :water_amout_new)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def render_result_action(result, action, path = electric_waters_path, model = "room: #{@room.name}")
    name = 'electric_water_list'
    frame_back_name = 'new_electric_water'
    render_result(result:, path:, model:, action:, name:, frame_back_name:)
  end

  def prepare_index
    @rooms = current_user.rooms.all
    @pagy, @rooms = pagy(@rooms, items: 9)
  end
end
