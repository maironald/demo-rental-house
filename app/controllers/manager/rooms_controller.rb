# frozen_string_literal: true

module Manager
  class RoomsController < BaseController
    before_action :prepare_index, only: %i[index]
    before_action :set_room, only: %i[show edit update destroy]

    def index
      @pagy, @rooms = pagy(@rooms, items: 9)
    end

    def show; end

    def new
      @room = Room.new
    end

    def edit; end

    def create
      @room = current_user.rooms.new(room_params)
      render_result(@room.save, 'new_room', @room.name)
    end

    def update
      result = @room.update(room_params)
      render_result(result, 'new_room', @room.name)
    end

    def destroy
      @room.really_destroy!
      redirect_to rooms_path, notice: t('common.destroy.success', model: @room.name)
    end

    private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room)
            .permit(
              :name,
              :length,
              :width,
              :price_room,
              :limit_residents,
              :description,
              :electric_amount_new,
              :electric_amount_old,
              :water_amout_new,
              :water_amout_old
            )
    end

    def prepare_index
      total_rooms = current_user.rooms
      @room_total = total_rooms.size
      @room_used = total_rooms.rooms_rented.size
      @room_left = @room_total - @room_used
      @rooms = Manager::Rooms::GetListRoomsService.call(total_rooms, params)
      @total_rooms = @rooms.size
    end
  end
end
