# frozen_string_literal: true

class RoomsController < BaseController
  include ApplicationHelper
  before_action :set_room, only: %i[show edit update destroy]

  def index
    count_people_in_room
    @room_ids = Renter.distinct.pluck(:room_id)
    @rooms = current_user.rooms.all
    @rooms = @rooms.search_by_name(params[:search]) if params[:search]
    @rooms = @rooms.rooms_rented if params[:selected_value] == 'rented'
    @rooms = @rooms.rooms_empty(@room_ids) if params[:selected_value] == 'empty'

    @total_rooms = @rooms.count
    @pagy, @rooms = pagy(@rooms, items: 9)
  end

  def show; end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = current_user.rooms.build(room_params)
    respond_to do |format|
      if @room.save
        reload_rooms_with_pagination(format, type: :success, message: "The room '#{@room.name}' was successfully created.")
      else
        render_errors(format, :new)
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        reload_rooms_with_pagination(format, type: :success, message: "The room '#{@room.name}' was successfully edited.")
      else
        render_errors(format, :edit)
      end
    end
  end

  def destroy
    @room.really_destroy!
    respond_to do |format|
      reload_rooms_with_pagination(format, type: :success, message: "The room '#{@room.name}' was successfully deleted.")
    end
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

  def check_amount(old, new)
    return true if old <= new

    false
  end

  def reload_rooms_with_pagination(format, options = {})
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
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_room', partial: 'rooms/form')] }
  end
end
