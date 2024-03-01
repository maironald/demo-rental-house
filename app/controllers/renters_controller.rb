# frozen_string_literal: true

class RentersController < BaseController
  before_action :prepare_index, only: %i[index]
  before_action :set_renter, only: %i[show edit update destroy]
  before_action :set_room, only: %i[create update]

  def index; end

  def show; end

  def new
    @renter = Renter.new
  end

  def edit
    @renter.deposit = format_to_vnd_not_unit(@renter.deposit)
  end

  def create
    remove_decimal_separator(params[:renter], %i[deposit])
    @renter = @room.renters.new(renter_params)

    render_result_with_room(@renter.save, :new, @room)
  end

  def update
    remove_decimal_separator(params[:renter], %i[deposit])
    render_result_action(@renter.update(renter_params), :edit)
  end

  def destroy
    @renter.really_destroy!
    render_destroy
  end

  def show_renters
    @renter_in_rooms = Renter.where(room_id: params[:room_id])
    @renter_main = Renter.find_by(room_id: params[:room_id], renter_type: 'main')
  end

  private

  def set_renter
    @renter = Renter.find(params[:id])
  end

  def set_room
    @room = Room.find_by(id: params[:room_id])
  end

  def renter_params
    params.require(:renter).permit(:name, :phone_number, :identity, :address, :gender, :renter_type, :deposit)
  end

  def render_result_action(result, action, path = renters_path, model = "renter: #{@renter.name}")
    name = 'renter_list'
    frame_back_name = 'new_renter'
    render_result(result:, path:, model:, action:, name:, frame_back_name:)
  end

  def render_result_with_room(result, action, renter)
    total_rooms = current_user.rooms
    @room_info = Rooms::GetInfoRoomsService.call(total_rooms)
    @rooms = Rooms::GetListRoomsService.call(total_rooms, params)
    @total_rooms = @rooms.size
    @pagy, @rooms = pagy(@rooms, items: 9)
    if result
      message = "The renter '#{renter.name}' was successfully edited."
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: message }
        format.turbo_stream do
          flash.now[:success] = message
          render turbo_stream: [
            turbo_stream.remove('my_modal_4'),
            turbo_stream.replace('room_list', partial: 'rooms/table', locals: { rooms: @rooms, pagy: @pagy, total_rooms: @total_rooms, room_info: @room_info }),
            render_turbo_stream_flash_messages
          ]
        end
      end
    else
      respond_to do |format|
        format.html { render action, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_renter', partial: 'renters/form')] }
      end
    end
  end

  def render_destroy
    render_result_destroy(
      name: 'renter_list',
      path: renters_path,
      model: @renter.name,
      func: prepare_index
    )
  end

  def prepare_index
    # get all the renters id who have rented a room through current user
    renters = Renter.includes(:room).where(rooms: { user_id: current_user.id })
    @renters = Renters::GetListRentersService.call(renters, params)

    @pagy, @renters = pagy(@renters, items: 9)
  end
end
