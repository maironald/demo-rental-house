# frozen_string_literal: true

class RoomsController < BaseController
  before_action :set_room, only: %i[show edit update destroy]

  def index
    count_people_in_room
    @room_ids = Renter.distinct.pluck(:room_id)
    @rooms = current_user.rooms.all
    @rooms = @rooms.search_by_name(params[:search]) if params[:search]
    @rooms = @rooms.filter_room_rented(@room_ids) if params[:selected_value] == 'rented'
    @rooms = @rooms.filter_room_empty(@room_ids) if params[:selected_value] == 'empty'

    @total_rooms = @rooms.count
    @pagy, @rooms = pagy(@rooms, items: 9)

    # @room_ids = Renter.distinct.pluck(:room_id)
    # @rooms = (@rooms.where if params[:status] == 'US')
  end

  def show; end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.check_electric_water_amount
      respond_to { |format| format.turbo_stream { flash.now[:notice] = 'Room was created failed because the amount old is bigger than the amount new.' } }
    elsif @room.save
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: 'Room was successfully created.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('room-list', partial: 'rooms/table', locals: { room: @room }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @room.check_electric_water_amount
      respond_to { |format| format.turbo_stream { flash.now[:notice] = 'Room was created failed because the amount old is bigger than the amount new.' } }
    elsif @room.update(room_params)
      respond_to do |format|
        redirect_to rooms_path, notice: 'Room was successfully edited.'
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('room-list', partial: 'rooms/table', locals: { room: @room }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: 'Room was successfully deleted.'
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :length, :width, :price_room, :limit_residents, :description, :electric_amount_new, :electric_amount_old, :water_amout_new, :water_amout_old)
  end

  def count_people_in_room
    @room_total = current_user.rooms.count
    @room_used = Renter.where(room_id: current_user.rooms.pluck(:id), renter_type: 'main').count
    @room_left = @room_total - @room_used
  end
end
